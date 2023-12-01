locals {
  create_certificate          = var.create_certificate
  create_route53_records_only = var.create_route53_records_only

  # Get distinct list of domains and SANs
  distinct_domain_names = coalescelist(var.distinct_domain_names, distinct(
    [for s in concat([var.domain_name], var.subject_alternative_names) : replace(s, "*.", "")]
  ))

  # Get the list of distinct domain_validation_options, with wildcard
  # domain names replaced by the domain name
  validation_domains = local.create_certificate || local.create_route53_records_only ? distinct(
    [for k, v in try(aws_acm_certificate.this[0].domain_validation_options, var.acm_certificate_domain_validation_options) : merge(
      tomap(v), { domain_name = replace(v.domain_name, "*.", "") }
    )]
  ) : []
}