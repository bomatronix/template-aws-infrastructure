locals {
  product_tags = jsondecode(var.product_tags)
  # Use existing (via data source) or create new zone (will fail validation, if zone is not reachable)
  use_existing_route53_zone = true

  domain = "terraform-aws-modules-example.com"

  # Removing trailing dot from domain - just to be sure :)
  domain_name = trimsuffix(local.domain, ".")

  zone_id = try(data.aws_route53_zone.this[0].zone_id, data.aws_route53_zone.this[0].zone_id)
}