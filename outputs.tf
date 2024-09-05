output "dnssec_key_alias_arn" {
  description = "The Amazon Resource Name (ARN) of the key alias."
  value       = aws_kms_alias.dnssec_key_alias.arn
}

output "dnssec_flag" {
  description = "An integer that specifies how the key is used. For key-signing key (KSK), this value is always 257."
  value       = string
}

output "dnssec_key_alias_name" {
  description = "The display name of the alias."
  value       = aws_kms_alias.dnssec_key_alias.name
}

output "dnssec_key_arn" {
  description = "The Amazon Resource Name (ARN) of the key."
  value       = aws_kms_key.dnssec_key.arn
}

output "dnssec_key_id" {
  description = "The globally unique identifier for the key."
  value       = aws_kms_key.dnssec_key.key_id
}

output "dnssec_public_key" {
  description = "The public key, represented as a Base64 encoding, as required by RFC-4034 Page 5."
  value       = string
}

output "dnssec_signing_algorithm_type" {
  description = "An integer used to represent the signing algorithm. This value must follow the guidelines provided by RFC-8624 Section 3.1."
  value       = string
}
