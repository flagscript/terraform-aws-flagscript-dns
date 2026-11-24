variable "key_name" {
  default     = "dnssec"
  description = "The name of the DNSSEC KMS key. It is also used for the alias, alias/<key_name>."
  type        = string
}

variable "region" {
  default     = "us-east-1"
  description = "The AWS region for the provider."
  type        = string
}
