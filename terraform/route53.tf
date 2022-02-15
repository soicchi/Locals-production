data "aws_route53_zone" "zone" {
  name = "local-s-app.com"
}

resource "aws_route53_record" "record" {
  zone_id = data.aws_route53_zone.zone.id
  name    = data.aws_route53_zone.zone.name
  type    = "A"

  alias {
    name                   = aws_alb.alb.dns_name
    zone_id                = aws_alb.alb.zone_id
    evaluate_target_health = true
  }
}

#########################
# DNS Validation Record #
#########################

resource "aws_route53_record" "validation_record" {
  name = tolist(aws_acm_certificate.acm.domain_validation_options)[0].resource_record_name
  type = tolist(aws_acm_certificate.acm.domain_validation_options)[0].resource_record_type
  records = [tolist(aws_acm_certificate.acm.domain_validation_options)[0].resource_record_value]
  zone_id = data.aws_route53_zone.zone.id
  ttl     = 60
}

output "domain_name" {
  value = aws_route53_record.record.name
}