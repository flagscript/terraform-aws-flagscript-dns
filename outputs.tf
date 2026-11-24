
output "public_hosted_zone_arn" {
  description = "The Amazon Resource Name (ARN) of the public hosted zone."
  value       = aws_route53_zone.public_hosted_zone.arn
}

output "public_hosted_zone_domain" {
  description = "The domain name of the public hosted zone."
  value       = var.zone_domain
}

output "public_hosted_zone_id" {
  description = "The ID of the public hosted zone."
  value       = aws_route53_zone.public_hosted_zone.zone_id
}

output "public_hosted_zone_name_servers" {
  description = "The authoritative name servers for the public hosted zone."
  value       = aws_route53_zone.public_hosted_zone.name_servers
}

output "public_hosted_zone_primary_name_server" {
  description = "The primary authoritative name server for the public hosted zone."
  value       = aws_route53_zone.public_hosted_zone.name_servers[0]
}

output "public_hosted_zone_query_log_config_arn" {
  description = "The ARN of the query log configuration for the public hosted zone."
  value       = local.enable_query_logging ? aws_route53_query_log.query_log[0].arn : null
}

output "public_hosted_zone_query_log_config_id" {
  description = "The ID of the query log configuration for the public hosted zone."
  value       = local.enable_query_logging ? aws_route53_query_log.query_log[0].id : null
}

output "public_hosted_zone_query_log_group_arn" {
  description = "The ARN of the CloudWatch log group for the public hosted zone query logs."
  value       = local.enable_query_logging ? aws_cloudwatch_log_group.query_log_group[0].arn : null
}
