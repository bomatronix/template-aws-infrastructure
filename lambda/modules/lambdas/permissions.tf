
// add aws lambda permission for api gateway, read lambda_permission from variables.tf, add permissions as described in  list lambda_permissionsand depends on lambda_function_name
resource "aws_lambda_permission" "api_gateway_lambda_permission" {
  depends_on = [aws_lambda_function.lambdas]
  for_each   = { for key, value in var.lambda_permissions : key => value if value["type"] == "api_gateway" }
  #statement_id  = "AllowAPIGatewayInvoke"
  action        = each.value["action"]
  function_name = var.function_name
  principal     = each.value["principal"]
  source_arn    = "${data.aws_api_gateway_rest_api.rest_api[each.key["api_name"]].execution_arn}/*/${each.value["method"]}/${each.value["path"]}"
}

// read aws api getway rest api from aws
data "aws_api_gateway_rest_api" "rest_api" {
  for_each = { for key, value in var.lambda_permissions : key => value if value["type"] == "api_gateway" }
  name     = each.value["api_name"]
}


// add aws lambda permission for event bridge, read lambda_permission from variables.tf, add permissions as described in  list lambda_permissionsand depends on lambda_function_name
resource "aws_lambda_permission" "event_bridge_lambda_permission" {
  depends_on = [aws_lambda_function.lambdas]
  for_each   = { for key, value in var.lambda_permissions : key => value if value["type"] == "event_bridge" }
  statement_id_prefix = each.value["statement_id_prefix"]
  action        = each.value["action"]
  function_name = var.function_name
  principal     = each.value["principal"]
  source_arn    = "arn:aws:events:${var.region}:${var.aws_account_id}:rule/${each.value["event_bridge_rule_name"]}-${var.environment}"
}

// add aws lambda permission for s3 invocation , read lambda_permission from variables.tf, add permissions as described in  list lambda_permissionsand depends on lambda_function_name
resource "aws_lambda_permission" "s3_lambda_permission" {
  depends_on = [aws_lambda_function.lambdas]
  for_each   = { for key, value in var.lambda_permissions : key => value if value["type"] == "s3" }
  statement_id_prefix = each.value["statement_id_prefix"]
  action        = each.value["action"]
  function_name = var.function_name
  principal     = each.value["principal"]
  source_arn    = data.aws_s3_bucket.s3_bucket[each.key].arn
}

//read aws s3 bucket from aws
data "aws_s3_bucket" "s3_bucket" {
  for_each = { for key, value in var.lambda_permissions : key => value if value["type"] == "s3" }
  bucket   = "${each.value["bucket_name"]}-${var.environment}"
}





