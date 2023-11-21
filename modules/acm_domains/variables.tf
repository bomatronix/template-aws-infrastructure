variable "is_private_zone" {
  type        = bool
  description = "Is this a private zone"
  default     = false
  
}

variable "domain_validation_options" {
  type        = any
  description = "The domain validation options"
  
}
