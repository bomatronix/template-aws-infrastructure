output "lambda_function_arn" {
    value = aws_lambda_function.lambdas.arn
}

output "lambda_function_invoke_arn" {
    value = aws_lambda_function.lambdas.invoke_arn
}

output "lambda_function_name" {
    value = aws_lambda_function.lambdas.function_name
}
