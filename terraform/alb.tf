#######
# ALB #
#######

resource "aws_alb" "alb" {
  name                       = "locals-alb"
  load_balancer_type         = "application"
  internal                   = false
  idle_timeout               = 60
  enable_deletion_protection = false

  subnets = [
    aws_subnet.public_1a.id,
    aws_subnet.public_1c.id
  ]

  access_logs {
    bucket  = aws_s3_bucket.alb_log.id
    enabled = true
  }

  security_groups = [aws_security_group.alb.id]

  tags = {
    Name = "locals-alb"
  }
}

output "alb_dns_name" {
  value = aws_alb.alb.dns_name
}

############
# Listener #
############

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.acm.arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.front.arn
  }

  depends_on = [
    aws_acm_certificate.acm,
    aws_acm_certificate_validation.acm_validation
  ]
}

resource "aws_alb_listener" "https_3000" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "3000"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.acm.arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.back.arn
  }

  depends_on = [
    aws_acm_certificate.acm,
    aws_acm_certificate_validation.acm_validation
  ]
}

################
# Target Group #
################

// Frontend //

resource "aws_alb_target_group" "front" {
  name                 = "front"
  target_type          = "ip"
  vpc_id               = aws_vpc.vpc.id
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 300

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = 200
    port                = "traffic-port"
    protocol            = "HTTP"
  }

  depends_on = [aws_alb.alb]
}

// Backend //

resource "aws_alb_target_group" "back" {
  name                 = "back"
  target_type          = "ip"
  vpc_id               = aws_vpc.vpc.id
  port                 = 3000
  protocol             = "HTTP"
  deregistration_delay = 300

  health_check {
    path                = "/api/v1/health_checks"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = 200
    port                = "traffic-port"
    protocol            = "HTTP"
  }

  depends_on = [aws_alb.alb]
}