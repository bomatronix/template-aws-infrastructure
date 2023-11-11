provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  #   token      = var.aws_token
  default_tags {
    tags = local.product_tags

  }

}
