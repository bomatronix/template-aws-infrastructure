locals {
  product_tags = jsondecode(var.product_tags)
  test_product_company_api_gateway_config = jsondecode(templatefile("${path.module}/configurations/test_product_company/api_gateway_config.json", {
    product = var.product
  }))

  test_product_company_open_api_json_string = jsondecode(templatefile("${path.module}/configurations/test_product_company/open_api_json_string.json", {
    product = var.product
  }))

  test_product_company_lambda_config = jsondecode(templatefile("${path.module}/configurations/test_product_company/lambda_config.json", {
    product = var.product
  }))

  test_product_company_lambda_layer_config = jsondecode(templatefile("${path.module}/configurations/test_product_company/lambda_layer_config.json", {
    product = var.product
  }))
  
}