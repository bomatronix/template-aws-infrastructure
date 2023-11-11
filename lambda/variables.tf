// variable for product
variable "product" {  
  type        = string
  description = "The product name"
}

//variable for aws_account_id
variable "aws_account_id" {
  type        = string
  description = "The aws account id"
}

//variable for product_tags
variable "product_tags" {
  type        = any
  description = "The product tags"
}


//variable for environment
variable "environment" {
  type        = string
  description = "The environment to deploy to"
}

//variable for aws_region
variable "aws_region" {
  default = "us-east-1"
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

//variable for lambda service role
variable "role_name" {
  type        = string
  description = "The lambda service role"
}