variable "create_route53_zone" {
  type        = bool
  description = "Create a Route53 zone"
  default     = false
  
}

# variable "vpc_id" {
#   type        = string
#   description = "The VPC ID"
  
# }

# variable "domain_name" {
#   type        = string
#   description = "The domain name"
  
# }

# variable "comment" {
#   type        = string
#   description = "The comment"
  
# }

variable "force_destroy" {
  type        = bool
  description = "Force destroy"
  default     = false
  
}   

variable "create" {
  type        = bool
  description = "Create the record"
  default     = true
  
}   

variable "enabled" {
  type        = bool
  description = "Enable the record"
  default     = true
  
}

# variable "private_enabled" {
#   type        = bool
#   description = "Enable the private zone"
#   default     = false
  
# }

# variable "delegation_set_id" {
#   type        = string
#   description = "The delegation set ID"
  
# }

# variable "public_enabled" {
#   type        = bool
#   description = "Enable the public zone"
#   default     = true
  
# }

variable "zone_id" {
    type        = string
    description = "The zone ID"
    default     = ""    
}

variable "records" {
  type        = any
  description = "The records"
  default     = []
  
}
variable "records_jsonencoded" {
  type        = string
  description = "The records in JSON encoded format"
  default     = ""
  
}


variable "record_enabled" {
  type        = bool
  default     = false
  description = "Whether to create Route53 record set."
}

variable "environment" {
  type        = string
  description = "The environment to deploy to"
  
}

variable "product_tags" {
  type        = any
  description = "The product tags"

  
}


variable "zone_name" {
  description = "Name of DNS zone"
  type        = string
  default     = null
}

variable "private_zone" {
  description = "Whether Route53 zone is private or public"
  type        = bool
  default     = false
}