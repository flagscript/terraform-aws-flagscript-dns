output "resource_policy_id" {
  description = "The ID of the CloudWatch log resource policy for Route 53 query logging."
  value       = aws_cloudwatch_log_resource_policy.route53_query_logging_policy.id
}
