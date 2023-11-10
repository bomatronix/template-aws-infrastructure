// terraform init code backend remote , providers,  etc
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "value"
    workspaces {
        name = "value"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

