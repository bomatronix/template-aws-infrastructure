module "zones" {
  source = "../../modules/zones"

  create = true

  zones = {
    "terraform-aws-modules-example.com" = {
      comment           = "terraform-aws-modules-example.com"
    #   delegation_set_id = module.delegation_sets.route53_delegation_set_id.main
      tags = {
        Name = "terraform-aws-modules-example.com"
      }
    }
  }

}

module "records" {
  source      = "../../"
  zone_name   = local.zone_name
#   zone_id    = local.zone_id
  environment = var.environment
  #   public_enabled = true
  #   record_enabled = true
  #   comment        = var.comment
  product_tags = local.product_tags

  #   domain_name = "testexample.com"
  #   delegation_set_id = var.delegation_set_id
  #   vpc_id = var.vpc_id

  records = [
    {
      name           = "test"
      type           = "CNAME"
      ttl            = 5
      records        = ["admin.testexample.com"]
      set_identifier = "test-primary"
      weighted_routing_policy = {
        weight = 90
      }
    }

  ]
  depends_on = [module.zones]
}

module "delegation_sets" {
  source = "../../modules/delegation-sets"

  create = true

  delegation_sets = {
    main = {}
  }

}
