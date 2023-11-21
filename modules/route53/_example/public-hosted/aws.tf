// terraform init code backend remote , providers,  etc
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "example-org-49d094"
    workspaces {
        name = "rout53_example_public-hosted"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

data aws_caller_identity this {
}
