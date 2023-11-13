output "rest_api_id" {
    value = aws_api_gateway_rest_api.api.id
    description = "API Gateway ID"
}

output "aws_api_gateway_domain_name" {
    value = aws_api_gateway_domain_name.api_gateway_domain_name.cloudfront_domain_name
    description = "API Gateway Domain Name"
}

output "reginal_domain_name" {
    value = aws_api_gateway_domain_name.api_gateway_domain_name.regional_domain_name
    description = "API Gateway Domain Name"
}

output "regional_zone_id" {
    value = aws_api_gateway_domain_name.api_gateway_domain_name.regional_zone_id
    description = "API Gateway Domain Name"
}

