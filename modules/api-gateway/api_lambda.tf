module "lambdas" {
  source                       = "./../lambdas"
  for_each                     = var.api_lambda_config
  function_name                = "${each.key}-${var.environment}"
  environment                  = var.environment
  filename                     = data.archive_file.place_hodler.output_path
  handler                      = each.value["handler"]
  role_name                    = each.value["role_name"]
  runtime                      = each.value["runtime"]
  description                  = each.value["description"]
  timeout                      = each.value["timeout"]
  layers                       = each.value["layers"]
  mode                         = each.value["mode"]
  variables                    = each.value["env_vars"]
  subnet_ids                   = data.aws_subnets.private_app_subnets.ids
  security_group_ids           = [data.aws_security_group.lambda_sg.id]
  lambda_permissions           = each.value["lambda_permissions"]
  lambda_event_source_mappings = each.value["lambda_event_source_mappings"]
  aws_account_id               = var.aws_account_id
  memory_size                  = try(each.value["memory_size"], 128)

  depends_on   = [aws_iam_role.lambda_service_role, module.lambda_layers]
  product      = var.product
  company_name = var.company_name

}


// module lambda layers source "./mdoules/lambda_layers"
module "lambda_layers" {
  for_each            = var.api_lambda_layer_config
  source              = "./../lambda_layers"
  layer_name          = "${each.key}_${var.environment}"
  filename            = data.archive_file.place_hodler.output_path
  compatible_runtimes = each.value["compatible_runtimes"]
}
