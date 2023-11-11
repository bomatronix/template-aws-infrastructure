//create resource for lambda function with all the variables
resource "aws_lambda_function" "lambdas" {
    function_name    = var.function_name
    handler          = var.handler
    role             = data.aws_iam_role.service_role.arn
    runtime          = var.runtime
    description      = var.description
    layers           = length(var.layers) == 0 ? [] : [for layers in data.aws_lambda_layer_version.layers: layers.arn]
    timeout          = var.timeout
    memory_size      = var.memory_size
    reserved_concurrent_executions = var.reserved_concurrent_executions
    publish          = var.publish
    vpc_config {
        subnet_ids         = var.subnet_ids
        security_group_ids = var.security_group_ids
    }
    environment {
        variables = local.env_vars
    }
    tracing_config {
        mode = var.mode
    }
}

data aws_lambda_layer_version layers {
    for_each = toset(var.layers)
    layer_name = "${each.key}_${var.environment}"
}
