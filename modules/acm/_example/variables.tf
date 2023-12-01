//variable for environment
variable "environment" {
  type        = string
  description = "The environment to deploy to"
}

//variable for aws_region
variable "aws_region" {
  default     = "us-east-1"
  type        = string
  description = "The aws region"
}

//variable for aws_access_key 
variable "aws_access_key" {
  type        = string
  description = "The aws aws_access_key"
}

//variable for aws_secret_key
variable "aws_secret_key" {
  type        = string
  description = "The aws aws_secret_key"
}

//variable for product_tags
variable "product_tags" {
  type        = any
  description = "The product tags"
}

