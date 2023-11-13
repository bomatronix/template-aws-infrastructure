
variable "name" {
  type        = string
  description = "The name of the API Gateway"
}


variable "openapi_spec" {
  type        = string
  description = "The OpenAPI specification of the API Gateway"
}

variable "standard_tags" {
  type        = map(string)
  description = "The standard tags to apply to all resources"
}

variable "acm_certificate_arn" {
  type        = string
  description = "The ARN of the ACM certificate"
}

variable "enviornment" {
  type        = string
  description = "The environment to deploy to"
}

variable "product" {
  type        = string
  description = "The product to deploy"
}

variable "logging_level" {
  type        = string
  description = "The logging level of the Lambda function"
  
}

variable "usage_plan_limit" {
  type        = number
  description = "The usage plan limit"
  
}

variable "usage_plan_period" {
  type        = string
  description = "The usage plan period"
  
}

variable "usage_plan_offset" {
  type        = number
  description = "The usage plan offset"
}

variable "usage_plan_burst_limit" {
  type        = number
  description = "The usage plan burst limit"
}

variable "usage_plan_rate_limit" {
  type        = number
  description = "The usage plan rate limit"
}

variable "api_gw_log_retention_in_days" {
  type        = number
  description = "The API Gateway log retention in days"
}