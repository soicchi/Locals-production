resource "aws_acm_certificate" "acm" {
  domain_name               = aws_route53_record.record.name
  subject_alternative_names = []
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "locals-certificate"
  }
}

resource "aws_acm_certificate_validation" "acm_validation" {
  certificate_arn = aws_acm_certificate.acm.arn
  validation_record_fqdns = [
    aws_route53_record.validation_record.fqdn
  ]
}