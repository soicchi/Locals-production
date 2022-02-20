###########
# Cluster #
###########

resource "aws_ecs_cluster" "cluster" {
  name = "locals-cluster"

  tags = {
    Name = "locals-cluster"
  }
}

#########
# Front #
#########

// Task Definition //

resource "aws_ecs_task_definition" "front" {
  family                   = "locals-front"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("./tasks/front_definition.json")
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}

// Service //

resource "aws_ecs_service" "front" {
  name                              = "locals-front-service"
  cluster                           = aws_ecs_cluster.cluster.arn
  task_definition                   = aws_ecs_task_definition.front.arn
  desired_count                     = 2
  launch_type                       = "FARGATE"
  platform_version                  = "1.4.0"
  health_check_grace_period_seconds = 60

  network_configuration {
    assign_public_ip = false
    security_groups  = [aws_security_group.ecs.id]

    subnets = [
      aws_subnet.private_1a.id,
      aws_subnet.private_1c.id
    ]
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.front.arn
    container_name   = var.FRONT_CONTAINER_NAME
    container_port   = 80
  }
}

########
# Back #
########

// Task Definition //

resource "aws_ecs_task_definition" "back" {
  family                   = "locals-back"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("./tasks/back_definition.json")
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}

resource "aws_ecs_task_definition" "db_migrate_reset" {
  family                   = "locals-db-migrate-reset"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("./tasks/db_migrate_reset_definition.json")
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}

resource "aws_ecs_task_definition" "db_seed" {
  family                   = "locals-db-seed"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("./tasks/db_seed_definition.json")
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}

// Service //

resource "aws_ecs_service" "back" {
  name                              = "locals-back-service"
  cluster                           = aws_ecs_cluster.cluster.arn
  task_definition                   = aws_ecs_task_definition.back.arn
  desired_count                     = 2
  launch_type                       = "FARGATE"
  platform_version                  = "1.4.0"
  health_check_grace_period_seconds = 60

  network_configuration {
    assign_public_ip = false
    security_groups  = [aws_security_group.ecs.id]

    subnets = [
      aws_subnet.private_1a.id,
      aws_subnet.private_1c.id
    ]
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.back.arn
    container_name   = var.BACK_CONTAINER_NAME
    container_port   = 3000
  }
}

########
# 権限 #
########

data "aws_iam_policy" "ecs_task_execution_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "ecs_task_execution" {
  source_json = data.aws_iam_policy.ecs_task_execution_role_policy.policy

  statement {
    effect = "Allow"
    actions = [
      "ssm:Getparameters",
      "kms:Decrypt"
    ]
    resources = ["*"]
  }
}

module "ecs_task_execution_role" {
  source     = "./iam_role"
  name       = "ecs-task-execution"
  identifier = "ecs-tasks.amazonaws.com"
  policy     = data.aws_iam_policy_document.ecs_task_execution.json
}