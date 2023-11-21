resource "aws_acm_certificate" "api_cert" {
    domain_name       = "${var.name}-${var.environment}-certificate"
    validation_method = "DNS"

    tags = merge(var.product_tags, ({ "name" = "${var.name}-certificate" }))   
    
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_acm_certificate_validation" "api_validation" {
  certificate_arn = acm_certificate.api_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.domains : record.fqdn]

  depends_on = [ aws_route53_record.domains ]
}