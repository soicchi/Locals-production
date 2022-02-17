resource "aws_ssm_parameter" "aws_access_key_id" {
  name        = "access-key-id"
  type        = "SecureString"
  value       = var.AWS_ACCESS_KEY_ID
  description = "AWSのアクセスキーID"
}

resource "aws_ssm_parameter" "aws_secret_access_key" {
  name        = "secret-access-key"
  type        = "SecureString"
  value       = var.AWS_SECRET_ACCESS_KEY
  description = "AWSのシークレットアクセスキー"
}

resource "aws_ssm_parameter" "aws_account_id" {
  name        = "account-id"
  type        = "SecureString"
  value       = var.AWS_ACCOUNT_ID
  description = "AWSのアカウントID"
}

resource "aws_ssm_parameter" "aws_region" {
  name        = "region"
  type        = "SecureString"
  value       = var.AWS_REGION
  description = "AWSのリージョン"
}

resource "aws_ssm_parameter" "rails_master_key" {
  name        = "rails-master-key"
  type        = "SecureString"
  value       = var.RAILS_MASTER_KEY
  description = "Railsのマスターキー"
}

resource "aws_ssm_parameter" "db_password" {
  name        = "db-password"
  type        = "SecureString"
  value       = var.DB_PASSWORD
  description = "LocalsのDBのパスワード"
}

resource "aws_ssm_parameter" "db_username" {
  name        = "db-username"
  type        = "SecureString"
  value       = var.DB_USERNAME
  description = "LocalsのDBのユーザーネーム"
}

resource "aws_ssm_parameter" "db_name" {
  name        = "db-name"
  type        = "SecureString"
  value       = var.DB_NAME
  description = "LocalsのDB名"
}

resource "aws_ssm_parameter" "db_host" {
  name        = "db-host"
  type        = "SecureString"
  value       = aws_db_instance.db.address
  description = "本番環境用のDBホスト名"
}

resource "aws_ssm_parameter" "google_api_key" {
  name        = "google-api-key"
  type        = "SecureString"
  value       = var.GOOGLE_API_KEY
  description = "GoogleのAPIキー"
}