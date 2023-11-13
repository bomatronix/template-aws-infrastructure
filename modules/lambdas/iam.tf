// read iam role from aws
data "aws_iam_role" "service_role" {
    name = var.role_name
}