# "aws_route53_zone" "public_hosted_zone"
output "arn" {
  description = "The Amazon Resource Name (ARN) of the Hosted Zone."
  value       = aws_route53_zone.public_hosted_zone.arn
}
output "domain_name" {
  description = "The domain name associated with the hosted zone."
  value       = var.hosted_zone_name
}

output "name_servers" {
  description = "A list of name servers in associated (or default) delegation set. Find more about delegation sets in AWS docs."
  value       = aws_route53_zone.public_hosted_zone.name_servers
}

output "primary_name_server" {
  description = "The Route 53 name server that created the SOA record."
  value       = aws_route53_zone.public_hosted_zone.primary_name_server
}

output "zone_id" {
  description = "The Hosted Zone ID. This can be referenced by zone records."
  value       = aws_route53_zone.public_hosted_zone.zone_id
}
