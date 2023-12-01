locals {
  product_tags = jsondecode(var.product_tags)
  test_product_company_api_gateway_config = jsondecode(templatefile("${path.module}/configurations/test_product_company/api_gateway_config.json", {
    product = var.product
  }))

  test_product_company_open_api_json_string = templatefile("${path.module}/configurations/test_product_company/openapi_spec.json", {
    product = var.product
  })

  test_product_company_lambda_config = jsondecode(templatefile("${path.module}/configurations/test_product_company/api_lambda_config.json", {
    product = var.product
    company_name = var.company_name
  }))

  test_product_company_lambda_layer_config = jsondecode(templatefile("${path.module}/configurations/test_product_company/api_lambda_layer_config.json", {
    product = var.product
  }))
  
}