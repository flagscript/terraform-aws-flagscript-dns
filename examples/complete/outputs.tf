output "dnssec_key_arn" {
  description = "The ARN of the DNSSEC KMS key."
  value       = module.dnssec_key.dnssec_key_arn
}

output "public_hosted_zone_id" {
  description = "The ID of the public hosted zone."
  value       = module.dns.public_hosted_zone_id
}

output "public_hosted_zone_name_servers" {
  description = "The name servers to set at your domain registrar."
  value       = module.dns.public_hosted_zone_name_servers
}

output "public_hosted_zone_query_log_group_arn" {
  description = "The ARN of the CloudWatch log group that receives the query logs."
  value       = module.dns.public_hosted_zone_query_log_group_arn
}

output "query_log_resource_policy_id" {
  description = "The ID of the CloudWatch Logs resource policy for Route 53 query logging."
  value       = module.query_log_resource_policy.resource_policy_id
}
