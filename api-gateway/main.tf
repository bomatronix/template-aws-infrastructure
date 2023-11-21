module "test_api_gateway" {
  source              = "./../modules/api-gateway"
  for_each            = local.test_product_company_api_gateway_config
  name                = each.key
  company_name        = var.company_name
  compression_size    = each.value["compression_size"]
  standard_tags       = each.value["standard_tags"]
  environment         = var.environment
  logging_level       = each.value["logging_level"]
  acm_certificate_arn = each.value["acm_certificate_arn"]
  base_path           = each.value["base_path"]
  product             = var.product
  #   cognito_authorizer               = each.value["cognito_authorizer"]
  #   lambda_authorizer                = each.value["lambda_authorizer"]
  api_lambda_config            = local.test_product_company_lambda_config
  api_lambda_layer_config      = local.test_product_company_lambda_layer_config
  aws_account_id               = var.aws_account_id // why do I need this
  aws_region                   = var.aws_region     // why do I need this
  usage_plan_burst_limit       = each.value["usage_plan_burst_limit"]
  usage_plan_limit             = each.value["usage_plan_limit"]
  usage_plan_offset            = each.value["usage_plan_offset"]
  usage_plan_period            = each.value["usage_plan_period"]
  usage_plan_rate_limit        = each.value["usage_plan_rate_limit"]
  api_gw_log_retention_in_days = each.value["api_gw_log_retention_in_days"]
  #   authorizer_azure_app_id          = each.value["authorizer_azure_app_id"]
  #   authorizer_azure_tenent_id       = each.value["authorizer_azure_tenent_id"]
  #   authorizer_cognoito_user_pool_id = each.value["authorizer_cognoito_user_pool_id"]
  open_api_json_string = each.value["open_api_json_string"]

  #   depends_on = [module.lambdas]
}
