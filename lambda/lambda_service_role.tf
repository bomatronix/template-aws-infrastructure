//aws iam role for lambda_service_role
resource "aws_iam_role" "lambda_service_role" {
  name = "${var.product}.lambda-service.role"

  lifecycle {
    ignore_changes = [assume_role_policy]
  }

  inline_policy {
    name   = "lambda-service-role-policy"
    policy = data.aws_iam_policy_document.lambda_service_role_policy.json
  }

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })
}

data "aws_iam_policy_document" "lambda_service_role_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "arn:aws:logs:us-east-1:${var.aws_account_id}:log-group:/aws/lambda/*"
    ]

    effect = "Allow"
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [ "arn:aws:s3:::${var.product}" ]
  }

  statement {
    effect = "Allow"
    actions = [
      "lambda:Invoke*",
      "lambda:List*",
      "lambda:Get*"
    ]
    resources = [ "arn:aws:lambda:*:${var.aws_account_id}:function:*" ]
  }


  statement {
    effect = "Allow"
    actions = [
        "events:Describe*",
        "events:List*"
    ]
    resources = [ "arn:aws:events:*:${var.aws_account_id}:*" ]
  }

  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:ListMetricData",
      "cloudwatch:GetMetricData"
    ]
    resources = [ "arn:aws:cloudwatch:*:${var.aws_account_id}:*" ]
  }
}
