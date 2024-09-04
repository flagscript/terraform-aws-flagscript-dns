# REQUIRED PARAMETERS
# These parameters must be supplied when consuming this module.

# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
variable "key_deletion_window_in_days" {
  default     = 7
  description = "The waiting period, specified in number of days. Defaults to 7."
  type        = number

  validation {
    condition     = var.key_deletion_window_in_days > 6 && var.key_deletion_window_in_days < 31
    error_message = "Var deletion_window_in_days must be between 7 and 30, inclusive."
  }
}

variable "enable_key_rotation" {
  default     = false
  description = "Specifies whether dnsseckey rotation is enabled. Defaults to false."
  type        = bool
}

variable "dnssec_hosted_zone_ids" {
  default     = []
  description = "List of hosted zones ids to use dnssec with."
  type        = list(string)
}
