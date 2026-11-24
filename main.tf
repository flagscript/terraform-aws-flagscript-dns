# Route 53
## Public Hosted Zone
resource "aws_route53_zone" "public_hosted_zone" {
  comment       = "Public hosted zone for the ${var.zone_domain} domain."
  force_destroy = var.force_destroy_records
  name          = var.zone_domain

  tags = merge(
    local.common_tags,
    {
      "Name" = var.zone_domain
    }
  )
}

## Dnssec signing key
resource "aws_route53_key_signing_key" "dnssec_signing_key" {
  count                      = local.enable_dnssec ? 1 : 0
  hosted_zone_id             = aws_route53_zone.public_hosted_zone.zone_id
  key_management_service_arn = var.dnssec_key_arn
  name                       = "dnssec-signing-key"
}

resource "aws_route53_hosted_zone_dnssec" "dnssec" {
  depends_on = [
    aws_route53_key_signing_key.dnssec_signing_key
  ]
  count          = local.enable_dnssec ? 1 : 0
  hosted_zone_id = aws_route53_zone.public_hosted_zone.zone_id
  signing_status = var.dnssec_signing_status
}
