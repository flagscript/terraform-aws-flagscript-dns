# REQUIRED PARAMETERS
# These parameters must be supplied when consuming this module.
variable "dnssec_public_key" {
  description = "The public key, represented as a Base64 encoding, as required by RFC-4034 Page 5."
  type        = string
}

variable "dnssec_flag" {
  description = "An integer that specifies how the key is used. For key-signing key (KSK), this value is always 257."
  type        = string
}

variable "domain_name" {
  description = "The name of the registered domain.."
  type        = string
}

variable "dnssec_signing_algorithm_type" {
  description = "An integer used to represent the signing algorithm. This value must follow the guidelines provided by RFC-8624 Section 3.1."
  type        = string
}

# variable "contact_type" {
#   description = "Indicates whether the contact is a person, company, association, or public organization."
#   type        = string

#   validation {
#     condition     = contains(["PERSON", "COMPANY", "ASSOCIATION", "PUBLIC_BODY", "RESELLER"], var.contact_type)
#     error_message = "Variable contact_type has invalid value."
#   }
# }

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
