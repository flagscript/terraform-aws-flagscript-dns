# REQUIRED PARAMETERS
# These parameters must be supplied when consuming this module.
variable "hosted_zone_name" {
  description = "The name of the hosted zone."
  type        = string
}

variable "dnssec_key_arn" {
  description = "The Amazon Resource Name (ARN) of the dnssec key."
  type        = string
}

# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
variable "log_retention_in_days" {
  default     = 30
  description = "The number of days you want to retain log events in the specified log group."
  type        = number
}
