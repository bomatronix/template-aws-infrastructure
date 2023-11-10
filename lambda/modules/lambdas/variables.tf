variable "function_name" {
  type        = string
  description = "The name of the Lambda function"
}

variable "environment" {
  type        = string
  description = "The environment to deploy to"

}

// variable for filename    
variable "filename" {
  type        = string
  description = "The filename of the Lambda function"
}

// variable for handler
variable "handler" {
  type        = string
  description = "The handler of the Lambda function"
}

// variable for role_name   
variable "role_name" {
  type        = string
  description = "The name of the IAM role"
}

// variable for runtime
variable "runtime" {
  type        = string
  description = "The runtime of the Lambda function"
}

//variable for description
variable "description" {
  type        = string
  description = "The description of the Lambda function"
}

//variable for layers
variable "layers" {
  type        = list(string)
  description = "The list of Lambda layers"
}

//variable for mode
variable "mode" {
  type        = string
  description = "The mode of the Lambda function"
}

//variable for variables
variable "variables" {
  type        = map(string)
  description = "The map of Lambda environment variables"
}

//variable for subnet_ids
variable "subnet_ids" {
  type        = list(string)
  description = "The list of subnet IDs"
}

//variable for security_group_ids
variable "security_group_ids" {
  type        = list(string)
  description = "The list of security group IDs"
}

//variable for lambda_permissions
variable "lambda_permissions" {
  type        = list(string)
  description = "The list of Lambda permissions"
}

//varible for lambda_event_source_mappings
variable "lambda_event_source_mappings" {
  type        = list(string)
  description = "The list of Lambda event source mappings"
}

//variable for region
variable "region" {
  type        = string
  description = "The region to deploy to"
  default     = "us-east-1"
}

//variable for rest_api_id
variable "rest_api_id" {
  type        = string
  description = "The ID of the API Gateway REST API"
}

//variable for aws_account_id
variable "aws_account_id" {
  type        = string
  description = "The AWS account ID"
}

//variable for memory_size
variable "memory_size" {
  type        = number
  description = "The amount of memory in MB your Lambda Function can use at runtime"
  default     = 128
}

//variable for product 
variable "product" {
  type        = string
  description = "The product name"
}

variable "timeout" {
  description = "The amount of time that AWS Lambda allows a function to run before stopping it."
  type        = number
  default     = 3
}

variable "publish" {
  type    = bool
  default = false
}

variable "reserved_concurrent_executions" {
  type    = number
  default = 0
}
