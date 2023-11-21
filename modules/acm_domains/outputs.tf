output fqdns {
    description = "value of the certificate arn"
    value = [for record in aws_route53_record.domains : record.fqdn]
}