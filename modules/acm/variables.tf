variable "name" {
  type        = string
  description = "The name of the API Gateway"

}

variable "environment" {
  type        = string
  description = "The environment"

}

variable "product_tags" {
  type        = map(string)
  description = "The product tags"
  default = {

  }
}

variable "is_private_zone" {
  type        = bool
  description = "Is this a private zone"
  default     = false

}
