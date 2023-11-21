data "aws_route53_zone" "zone" {
    name = var.zone_name    
    private_zone = false
}


resource "aws_route53_record" "domains" {
    for_each = {
        for dvo in aws_acm_certificate. 
    }
  
}