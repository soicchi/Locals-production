resource "aws_ecr_repository" "front" {
  name                 = "locals-app-front-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  provisioner "local-exec" {
    command = "sh ./dockerbuild_front.sh"
    environment = {
      AWS_REGION           = var.AWS_REGION
      FRONT_CONTAINER_NAME = var.FRONT_CONTAINER_NAME
      ECR_REPO             = aws_ecr_repository.front.repository_url
      AWS_ACCOUNT_ID       = var.AWS_ACCOUNT_ID
    }
  }
}

resource "aws_ecr_lifecycle_policy" "front" {
  repository = aws_ecr_repository.front.name
  policy = jsonencode(
    {
      rules = [
        {
          action = {
            type = "expire"
          }
          description  = "最新の1つを残してイメージを削除する"
          rulePriority = 1
          selection = {
            countNumber = 1
            countType   = "imageCountMoreThan"
            tagStatus   = "any"
          }
        },
      ]
    }
  )
}

resource "aws_ecr_repository" "back" {
  name                 = "locals-app-back-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  provisioner "local-exec" {
    command = "sh ./dockerbuild_back.sh"
    environment = {
      AWS_REGION          = var.AWS_REGION
      BACK_CONTAINER_NAME = var.BACK_CONTAINER_NAME
      ECR_REPO            = aws_ecr_repository.back.repository_url
      AWS_ACCOUNT_ID      = var.AWS_ACCOUNT_ID
    }
  }
}

resource "aws_ecr_lifecycle_policy" "back" {
  repository = aws_ecr_repository.back.name
  policy = jsonencode(
    {
      rules = [
        {
          action = {
            type = "expire"
          }
          description  = "最新の1つを残してイメージを削除する"
          rulePriority = 1
          selection = {
            countNumber = 1
            countType   = "imageCountMoreThan"
            tagStatus   = "any"
          }
        },
      ]
    }
  )
}