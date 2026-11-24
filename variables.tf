# REQUIRED PARAMETERS
# These parameters must be supplied when consuming this module.
variable "zone_domain" {
  description = "The domain name of the hosted zone."
  type        = string
}

# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
variable "dnssec_key_arn" {
  default     = null
  description = "The Amazon Resource Name (ARN) of the dnssec KMS key."
  type        = string
}

variable "dnssec_signing_status" {
  default     = "NOT_SIGNING"
  description = "The status of the DNSSEC signing for the hosted zone. Defaults to 'NOT_SIGNING'."
  type        = string

  validation {
    condition     = contains(["NOT_SIGNING", "SIGNING"], var.dnssec_signing_status)
    error_message = "Var dnssec_signing_status must be 'NOT_SIGNING' or 'SIGNING'."
  }
}

variable "enable_query_logging" {
  default     = false
  description = "Specifies whether to enable query logging for the hosted zone. Defaults to false."
  type        = bool
}

variable "force_destroy_records" {
  default     = false
  description = "Specifies whether to force destroy the records when deleting the zone. Defaults to false."
  type        = bool
}

variable "log_retention_days" {
  description = "How long to keep the domains query logs."
  type        = number
  default     = 7

  validation {
    condition     = contains([0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731], var.log_retention_days)
    error_message = "The log_retention_days value must be one of 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, or 731. If you select 0, the events in the log group are always retained and never expire."
  }
}

variable "tags" {
  default     = {}
  description = "Additional tags to merge into module tags."
  type        = map(string)
}


