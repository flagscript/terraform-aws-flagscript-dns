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
variable "admin_privacy" {
  default     = true
  description = "Whether domain administrative contact information is concealed from WHOIS queries."
  type        = bool
}

variable "auto_renew" {
  default     = true
  description = "Whether the domain registration is set to renew automatically."
  type        = bool
}

variable "billing_privacy" {
  default     = true
  description = "Whether domain billing contact information is concealed from WHOIS queries."
  type        = bool
}

variable "log_retention_in_days" {
  default     = 30
  description = "The number of days you want to retain log events in the specified log group."
  type        = number
}

variable "registrant_privacy" {
  default     = true
  description = "Whether domain registrant contact information is concealed from WHOIS queries."
  type        = bool
}

variable "tech_privacy" {
  default     = true
  description = "Whether domain technical contact information is concealed from WHOIS queries."
  type        = bool
}

variable "transfer_lock" {
  default     = true
  description = "Whether the domain is locked for transfer."
  type        = bool
}
