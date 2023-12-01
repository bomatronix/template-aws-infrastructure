data "aws_route53_zone" "this" {
  count = local.use_existing_route53_zone ? 1 : 0

  name         = local.domain_name
  private_zone = false
}

module "acm" {
  source      = "../"
  name        = "acm"
  environment = "dev"
  domain_name = local.domain_name
  zone_id     = local.zone_id

  subject_alternative_names = [
    "*.alerts.${local.domain_name}",
    "new.sub.${local.domain_name}",
    "*.${local.domain_name}",
    "alerts.${local.domain_name}",
  ]

  validation_method = "DNS"

  tags = {
    Name = local.domain_name
  }
}
