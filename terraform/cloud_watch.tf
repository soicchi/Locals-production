resource "aws_cloudwatch_log_group" "front" {
  name              = "/ecs/front"
  retention_in_days = 180
}

resource "aws_cloudwatch_log_group" "back" {
  name              = "/ecs/back"
  retention_in_days = 180
}

resource "aws_cloudwatch_log_group" "db_migrate" {
  name              = "/ecs/db_migrate"
  retention_in_days = 180
}

resource "aws_cloudwatch_log_group" "db_seed" {
  name              = "/ecs/db_seed"
  retention_in_days = 180
}