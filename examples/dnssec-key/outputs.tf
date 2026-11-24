output "dnssec_key_alias_name" {
  description = "The alias of the DNSSEC KMS key."
  value       = module.dnssec_key.dnssec_key_alias_name
}

output "dnssec_key_arn" {
  description = "The ARN of the DNSSEC KMS key. Pass it to the root module's dnssec_key_arn input."
  value       = module.dnssec_key.dnssec_key_arn
}
