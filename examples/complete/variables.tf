variable "dnssec_key_name" {
  default     = "dnssec-example"
  description = "The name of the DNSSEC KMS key."
  type        = string
}

variable "dnssec_signing_status" {
  default     = "SIGNING"
  description = "The DNSSEC signing status for the hosted zone: 'SIGNING' or 'NOT_SIGNING'."
  type        = string
}

variable "log_retention_days" {
  default     = 30
  description = "How many days to keep the query logs."
  type        = number
}

variable "region" {
  default     = "us-east-1"
  description = "The AWS region for the provider."
  type        = string
}

variable "zone_domain" {
  default     = "example.com"
  description = "The domain name of the hosted zone to create."
  type        = string
}
