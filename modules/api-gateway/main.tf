// create api gateway rest api resource
resource "aws_api_gateway_rest_api" "api" {
  name        = var.name
  description = "Proxy to handle all the requests"

  body = var.openapi_spec
  #   put_rest_api_mode = "merge" #TODO: uncomment this l   ine when terraform 0.13 is released

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = merge(var.standard_tags, tomap("name", var.name))

}

resource "aws_api_gateway_domain_name" "api_gateway_domain_name" {
  domain_name = "${var.name}-${var.enviornment}-certificate"
  #   regioregional_certificate_arn = var.acm_certificate_arn

  endpoint_configuration {
    types = ["REGIONAL"]
  }
  tags = tomap({ "name" = "${var.name}-domain-name" })
}

resource "aws_api_gateway_base_path_mapping" "api_gateway_base_path_mapping" {
  domain_name = aws_api_gateway_domain_name.api_gateway_domain_name.domain_name
  api_id      = aws_api_gateway_rest_api.api.id
  stage_name  = var.enviornment
}

resource "aws_api_gateway_request_validator" "api_gateway_request_validator" {
  name                        = "${var.name}-${var.enviornment}-request-validator"
  rest_api_id                 = aws_api_gateway_rest_api.api.id
  validate_request_body       = true
  validate_request_parameters = true
}

resource "aws_api_gateway_deployment" "api_gateway_deployment" {
  rest_api_id       = aws_api_gateway_rest_api.api.id
  stage_name        = var.enviornment
  stage_description = "Deployment at ${timestamp()}"

  depends_on = [
    aws_api_gateway_base_path_mapping.api_gateway_base_path_mapping,
    aws_api_gateway_request_validator.api_gateway_request_validator
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "api_gateway_stage" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = var.enviornment
  deployment_id = aws_api_gateway_deployment.api_gateway_deployment.id
  description   = "Deployment at ${timestamp()}"
  tags          = merge(var.standard_tags, ({ "name" = "${var.name}-stage" }))

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway_log_group.arn
    format = jsondecode({
      "authorizer"        = "$context.authorizer.error",
      "api_gw_error"      = "$context.error.message",
      "lamda_status"      = "$context.integration_status",
      "integration_error" = "$context.integration_error",
      "interation_status" = "$context.integration_status",
      "requestId"         = "$context.requestId",
      "ip"                = "$context.identity.sourceIp",
      "routeKey"          = "$context.routeKey",
      "caller"            = "$context.identity.caller",
      "user"              = "$context.identity.user",
      "requestTime"       = "$context.requestTime",
      "httpMethod"        = "$context.httpMethod",
      "resourcePath"      = "$context.resourcePath",
      "status"            = "$context.status",
      "protocol"          = "$context.protocol",
      "responseLength"    = "$context.responseLength"
    })
  }
}

//api gateway key resource
resource "aws_api_gateway_api_key" "api_gateway_api_key" {
  name = "${var.name}-${var.enviornment}-api-key"
  description = "API key for ${var.name} API Gateway"
  enabled = true

  depends_on = [
    aws_api_gateway_stage.api_gateway_stage,
    aws_api_gateway_usage_plan.api_gateway_usage_plan
  ]

}

resource "aws_api_gateway_usage_plan" "api_gateway_usage_plan" {
  name        = "${var.name}-${var.enviornment}-usage-plan"
  description = "Usage plan for ${var.name} API Gateway"
  api_stages {
    api_id = aws_api_gateway_rest_api.api.id
    stage  = aws_api_gateway_stage.api_gateway_stage.stage_name
  }
  product_code = var.product
  tags         = merge(var.standard_tags, ({ "name" = "${var.name}-usage-plan" }))

  quota_settings {
    limit = var.usage_plan_limit
    period = var.usage_plan_period
    offset = var.usage_plan_offset
  }

  throttle_settings {
    burst_limit = var.usage_plan_burst_limit
    rate_limit = var.usage_plan_rate_limit
  }
}


resource "aws_api_gateway_usage_plan_key" "api_gateway_usage_plan_key" {
    key_id = aws_api_gateway_api_key.api_gateway_api_key.id
    key_type = "API_KEY"
    usage_plan_id = aws_api_gateway_usage_plan.api_gateway_usage_plan.id
}

resource "aws_api_gateway_method_settings" "api_gateway_method_settings" {
  method_path = "*/*"
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = aws_api_gateway_stage.api_gateway_stage.stage_name

  settings {
    metrics_enabled    = true
    logging_level      = var.logging_level
    data_trace_enabled = true
    # throttling_burst_limit = 5000
    # throttling_rate_limit = 10000
  }

  depends_on = [
    aws_api_gateway_stage.api_gateway_stage,
    aws_api_gateway_usage_plan.api_gateway_usage_plan
  ]
}






