// read iam role from aws
data "aws_iam_role" "lambda_role" {
    name = var.role_name
}