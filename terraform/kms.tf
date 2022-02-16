resource "aws_kms_key" "kms_key" {
  description             = "Localsのカスタマーキー"
  enable_key_rotation     = true
  is_enabled              = true
  deletion_window_in_days = 30
}

resource "aws_kms_alias" "kms_alias" {
  name          = "alias/locals-kms"
  target_key_id = aws_kms_key.kms_key.key_id
}