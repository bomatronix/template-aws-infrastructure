//create resource for lambda function with all the variables
resource "aws_lambda_function" "lambda" {
    function_name    = var.function_name
    handler          = var.handler
    role             = data.aws_iam_role.lambda_role.arn
    runtime          = var.runtime
    description      = var.description
    layers           = var.layers
    timeout          = var.timeout
    memory_size      = var.memory_size
    reserved_concurrent_executions = var.reserved_concurrent_executions
    publish          = var.publish
    vpc_config {
        subnet_ids         = var.subnet_ids
        security_group_ids = var.security_group_ids
    }
    environment {
        variables = locals.environment
    }
    depends_on = [aws_iam_role_policy.lambda_policy]
}

