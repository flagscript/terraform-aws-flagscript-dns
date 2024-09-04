output "dnssec_key_alias_arn" {
  description = "The Amazon Resource Name (ARN) of the key alias."
  value       = aws_kms_alias.dnssec_key_alias.arn
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
