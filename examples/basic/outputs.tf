output "public_hosted_zone_id" {
  description = "The ID of the public hosted zone."
  value       = module.dns.public_hosted_zone_id
}

output "public_hosted_zone_name_servers" {
  description = "The name servers to set at your domain registrar."
  value       = module.dns.public_hosted_zone_name_servers
}
