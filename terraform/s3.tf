#################
# Public Bucket #
#################

resource "aws_s3_bucket" "public" {
  bucket        = "locals-images-bucket"
  force_destroy = true
  acl           = "public-read"

  cors_rule {
    allowed_headers = ["*"]
    allowed_origins = ["*"]
    allowed_methods = ["GET", "PUT", "POST"]
    max_age_seconds = 3000
  }

  tags = {
    Name = "locals-public-bucket"
  }
}

resource "aws_s3_bucket" "alb_log" {
  bucket        = "locals-alb-log-bucket"
  force_destroy = true

  lifecycle_rule {
    enabled = true

    expiration {
      days = "180"
    }
  }

  tags = {
    Name = "locals-alb-log-bucket"
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.public.id
}

########
# 権限 #
########

resource "aws_s3_bucket_policy" "alb_log" {
  bucket = aws_s3_bucket.alb_log.id
  policy = data.aws_iam_policy_document.alb_log.json
}

data "aws_iam_policy_document" "alb_log" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.alb_log.id}/*"]

    principals {
      type        = "AWS"
      identifiers = ["582318560864"]
    }
  }
}