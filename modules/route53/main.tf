data "aws_route53_zone" "this" {
  count = var.create && (var.zone_name != null) ? 1 : 0

#   zone_id      = var.zone_id
  name         = var.zone_name
  private_zone = var.private_zone
}

resource "aws_route53_record" "this" {
  for_each = { for k, v in local.recordsets : k => v if var.create && (var.zone_id != null || var.zone_name != null) }

  zone_id = data.aws_route53_zone.this[0].zone_id

  name                             = each.value.name != "" ? (lookup(each.value, "full_name_override", false) ? each.value.name : "${each.value.name}.${data.aws_route53_zone.this[0].name}") : data.aws_route53_zone.this[0].name
  type                             = each.value.type
  ttl                              = lookup(each.value, "ttl", null)
  records                          = try(each.value.records, null)
  set_identifier                   = lookup(each.value, "set_identifier", null)
  health_check_id                  = lookup(each.value, "health_check_id", null)
  multivalue_answer_routing_policy = lookup(each.value, "multivalue_answer_routing_policy", null)
  allow_overwrite                  = lookup(each.value, "allow_overwrite", false)

  dynamic "alias" {
    for_each = length(keys(lookup(each.value, "alias", {}))) == 0 ? [] : [true]

    content {
      name                   = each.value.alias.name
      zone_id                = try(each.value.alias.zone_id, data.aws_route53_zone.this[0].zone_id)
      evaluate_target_health = lookup(each.value.alias, "evaluate_target_health", false)
    }
  }

  dynamic "failover_routing_policy" {
    for_each = length(keys(lookup(each.value, "failover_routing_policy", {}))) == 0 ? [] : [true]

    content {
      type = each.value.failover_routing_policy.type
    }
  }

  dynamic "latency_routing_policy" {
    for_each = length(keys(lookup(each.value, "latency_routing_policy", {}))) == 0 ? [] : [true]

    content {
      region = each.value.latency_routing_policy.region
    }
  }

  dynamic "weighted_routing_policy" {
    for_each = length(keys(lookup(each.value, "weighted_routing_policy", {}))) == 0 ? [] : [true]

    content {
      weight = each.value.weighted_routing_policy.weight
    }
  }

  dynamic "geolocation_routing_policy" {
    for_each = length(keys(lookup(each.value, "geolocation_routing_policy", {}))) == 0 ? [] : [true]

    content {
      continent   = lookup(each.value.geolocation_routing_policy, "continent", null)
      country     = lookup(each.value.geolocation_routing_policy, "country", null)
      subdivision = lookup(each.value.geolocation_routing_policy, "subdivision", null)
    }
  }
}

# resource "aws_route53_record" "this" {
#   for_each = { for k, v in local.recordsets : k => v if var.enabled && var.record_enabled && (var.zone_id != null || var.public_enabled != null || var.private_enabled != null || var.domain_name != null) }

#   zone_id = local.zone_id

#   name                             = each.value.name != "" ? (lookup(each.value, "full_name_override", false) ? each.value.name : "${each.value.name}.${var.domain_name}") : var.domain_name
#   type                             = each.value.type
#   ttl                              = lookup(each.value, "ttl", null)
#   records                          = try(each.value.records, null)
#   set_identifier                   = lookup(each.value, "set_identifier", null)
#   health_check_id                  = lookup(each.value, "health_check_id", null)
#   multivalue_answer_routing_policy = lookup(each.value, "multivalue_answer_routing_policy", null)
#   allow_overwrite                  = lookup(each.value, "allow_overwrite", false)

#   dynamic "alias" {
#     for_each = length(keys(lookup(each.value, "alias", {}))) == 0 ? [] : [true]

#     content {
#       name                   = each.value.alias.name
#       zone_id                = try(each.value.alias.zone_id, local.zone_id)
#       evaluate_target_health = lookup(each.value.alias, "evaluate_target_health", false)
#     }
#   }

  #   dynamic "failover_routing_policy" {
  #     for_each = length(keys(lookup(each.value, "failover_routing_policy", {}))) == 0 ? [] : [true]

  #     content {
  #       type = each.value.failover_routing_policy.type
  #     }
  #   }

  #   dynamic "latency_routing_policy" {
  #     for_each = length(keys(lookup(each.value, "latency_routing_policy", {}))) == 0 ? [] : [true]

  #     content {
  #       region = each.value.latency_routing_policy.region
  #     }
  #   }

  #   dynamic "weighted_routing_policy" {
  #     for_each = length(keys(lookup(each.value, "weighted_routing_policy", {}))) == 0 ? [] : [true]

  #     content {
  #       weight = each.value.weighted_routing_policy.weight
  #     }
  #   }

  #   dynamic "geolocation_routing_policy" {
  #     for_each = length(keys(lookup(each.value, "geolocation_routing_policy", {}))) == 0 ? [] : [true]

  #     content {
  #       continent   = lookup(each.value.geolocation_routing_policy, "continent", null)
  #       country     = lookup(each.value.geolocation_routing_policy, "country", null)
  #       subdivision = lookup(each.value.geolocation_routing_policy, "subdivision", null)
  #     }
  #   }
#   depends_on = [
#     aws_route53_zone.public,
#     aws_route53_zone.private
#   ]
# }


# resource "aws_route53_zone_association" "default" {
#   count   = var.enabled && var.vpc_association_enabled && var.private_enabled ? 1 : 0
#   zone_id = aws_route53_zone.private.*.zone_id[0]
#   vpc_id  = var.secondary_vpc_id
# }


# resource "aws_route53_record" "public" {
#     for_each = var.create ? locals.recordsets : object({})

#     zone_id = data.aws_route53_zone.this.zone_id

#     name = each.value.name != "" ? "${each.value.name}.${data.aws_route53_zone.this.name}" : data.aws_route53_zone.this.name
#     type = each.value.type
#     ttl  = lookup(each.value, "ttl", null)
#     records = lookup(each.value, "records", null)

#     dynamic "alias" {
#         for_each = length(keys(lookup(each.value, "alias", {}))) == 0 ? []: [true]
#         content {
#             name                   = each.value.alias.name
#             zone_id                = each.value.alias.zone_id
#             evaluate_target_health = lookup(alias.value.alias, "evaluate_target_health", false)
#         }
#     }
# }
