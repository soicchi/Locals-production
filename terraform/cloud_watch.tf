resource "aws_cloudwatch_log_group" "front" {
  name              = "/ecs/front"
  retention_in_days = 180
}

resource "aws_cloudwatch_log_group" "back" {
  name              = "/ecs/back"
  retention_in_days = 180
}

resource "aws_cloudwatch_log_group" "db_migrate_reset" {
  name              = "/ecs/db-migrate-reset"
  retention_in_days = 180
}

resource "aws_cloudwatch_log_group" "db_migrate" {
  name              = "/ecs/db-migrate"
  retention_in_days = 180
}

resource "aws_cloudwatch_log_group" "db_seed" {
  name              = "/ecs/db-seed"
  retention_in_days = 180
}