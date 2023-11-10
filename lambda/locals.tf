locals {
  product_tags = jsondecode(var.product_tags)
  generic_lambda_config = jsondecode(templatefile("${path.module}/configurations/generic/lambda_config.json", {
    product = var.product
  })).value
  generic_lambda_layer_config = jsondecode(templatefile("${path.module}/configurations/generic/lambda_layer_config.json", {
    product = var.product
  })).value

  lambda_config = local.generic_lambda_config
  lambda_layer_config = local.generic_lambda_layer_config
}