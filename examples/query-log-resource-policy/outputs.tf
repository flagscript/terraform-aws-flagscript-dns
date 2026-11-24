output "resource_policy_id" {
  description = "The ID of the CloudWatch Logs resource policy for Route 53 query logging."
  value       = module.query_log_resource_policy.resource_policy_id
}
