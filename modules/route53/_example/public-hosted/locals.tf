locals {
  product_tags = jsondecode(var.product_tags)

  zone_name = sort(keys(module.zones.route53_zone_zone_id))[0]
#    zone_id = module.zones.route53_zone_zone_id["terraform-aws-modules-example.com"]

}