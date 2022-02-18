#####################
# DB Prameter Group #
#####################

resource "aws_db_parameter_group" "db_pg" {
  name   = "locals-db-parameter-group"
  family = "mysql8.0"

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
}

###################
# DB Option Group #
###################

resource "aws_db_option_group" "db_og" {
  name                 = "locals-db-option-group"
  engine_name          = "mysql"
  major_engine_version = "8.0"

  option {
    option_name = "MARIADB_AUDIT_PLUGIN"
  }
}

###################
# DB Subnet Group #
###################

resource "aws_db_subnet_group" "db_sg" {
  name       = "locals-db-subnet-group"
  subnet_ids = [aws_subnet.db_1a.id, aws_subnet.db_1c.id]

  tags = {
    Name = "Locals-db-subnet-group"
  }
}

###############
# DB Instance #
###############

resource "aws_db_instance" "db" {
  identifier              = "locals-db"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t2.micro"
  allocated_storage       = 20
  max_allocated_storage   = 100
  storage_encrypted       = true
  kms_key_id              = aws_kms_key.kms_key.arn
  storage_type            = "gp2"
  name                    = var.DB_NAME
  username                = var.DB_USERNAME
  password                = var.DB_PASSWORD
  multi_az                = true
  backup_retention_period = 7
  publicly_accessible     = false
  deletion_protection     = false
  skip_final_snapshot     = true
  port                    = 3306
  apply_immediately       = false
  vpc_security_group_ids  = [aws_security_group.rds.id]
  parameter_group_name    = aws_db_parameter_group.db_pg.name
  option_group_name       = aws_db_option_group.db_og.name
  db_subnet_group_name    = aws_db_subnet_group.db_sg.name
  enabled_cloudwatch_logs_exports = [
    "audit",
    "error",
    "general",
    "slowquery"
  ]

  lifecycle {
    ignore_changes = [password]
  }

  tags = {
    Name = "locals-db"
  }
}