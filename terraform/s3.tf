#################
# Public Bucket #
#################

resource "aws_s3_bucket" "public" {
  bucket        = "locals-images-bucket"
  force_destroy = true

  tags = {
    Name = "locals-public-bucket"
  }
}

resource "aws_s3_bucket" "alb_log" {
  bucket        = "locals-alb-log-bucket"
  force_destroy = true

  tags = {
    Name = "locals-alb-log-bucket"
  }
}

#####################
# Public Bucket ACL #
#####################

resource "aws_s3_bucket_acl" "public" {
  bucket = aws_s3_bucket.public.id
  acl    = "public-read"
}

#######################
# Public Bucket CORS #
#######################

resource "aws_s3_bucket_cors_configuration" "public" {
  bucket = aws_s3_bucket.public.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_origins = ["*"]
    allowed_methods = ["GET"]
  }
}

##################
# ALB Log Bucket #
##################

resource "aws_s3_bucket_lifecycle_configuration" "alb_log" {
  bucket = aws_s3_bucket.alb_log.id

  rule {
    id     = "alb-log"
    status = "Enabled"

    expiration {
      days = 30
    }
  }
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