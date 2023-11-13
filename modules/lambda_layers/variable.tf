//variable for layer_name
variable "layer_name" {
  type        = string
  description = "The name of the Lambda layer"
}

//variable for filename
variable "filename" {
  type        = string
  description = "The filename of the Lambda layer"
}

//variable for compaitible_runtimes
variable "compatible_runtimes" {
  type        = list(string)
  description = "The list of compatible runtimes"
}