variable "dnssec_key_alias_arn" {
  description = "The Amazon Resource Name (ARN) of the key alias."
  type        = string
}

variable "dnssec_key_alias_name" {
  description = "The display name of the alias."
  type        = string
}

variable "dnssec_key_arn" {
  description = "The Amazon Resource Name (ARN) of the key."
  type        = string
}

variable "dnssec_key_id" {
  description = "The globally unique identifier for the key."
  type        = string
}
