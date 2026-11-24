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
