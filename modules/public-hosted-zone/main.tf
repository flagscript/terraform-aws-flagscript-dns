# Cloudwatch
## Log Group
resource "aws_cloudwatch_log_group" "query_log_group" {
  name              = "/aws/route53/${var.hosted_zone_name}"
  retention_in_days = var.log_retention_in_days
}


# Route 53
## Public Hosted Zone
resource "aws_route53_zone" "public_hosted_zone" {
  comment = "Public hosted zone for the ${var.hosted_zone_name} domain."
  name    = var.hosted_zone_name

  tags = merge(
    local.common_tags,
    {
      name = var.hosted_zone_name
    }
  )
}

resource "aws_route53_query_log" "query_log" {
  cloudwatch_log_group_arn = aws_cloudwatch_log_group.query_log_group.arn
  zone_id                  = aws_route53_zone.public_hosted_zone.zone_id
}

## Dnssec signing key
resource "aws_route53_key_signing_key" "dnssec_signing_key" {
  hosted_zone_id             = aws_route53_zone.public_hosted_zone.zone_id
  key_management_service_arn = var.dnssec_key_arn
  name                       = "dnssec-signing-key"
}

resource "aws_route53_hosted_zone_dnssec" "dnssec" {
  depends_on = [
    aws_route53_key_signing_key.dnssec_signing_key
  ]
  hosted_zone_id = aws_route53_zone.public_hosted_zone.zone_id
  signing_status = "SIGNING"
}

# Route 53 Domains
## Import registered domain
resource "aws_route53domains_registered_domain" "registered_domain" {
  admin_privacy      = var.admin_privacy
  auto_renew         = var.auto_renew
  billing_privacy    = var.billing_privacy
  domain_name        = var.hosted_zone_name
  registrant_privacy = var.registrant_privacy
  tech_privacy       = var.tech_privacy
  transfer_lock      = var.transfer_lock

  tags = merge(
    local.common_tags,
    {
      name = var.hosted_zone_name
    }
  )
}

resource "aws_route53domains_delegation_signer_record" "registered_domain_signer_record" {
  domain_name = var.hosted_zone_name

  signing_attributes {
    algorithm  = aws_route53_key_signing_key.dnssec_signing_key.signing_algorithm_type
    flags      = aws_route53_key_signing_key.dnssec_signing_key.flag
    public_key = aws_route53_key_signing_key.dnssec_signing_key.public_key
  }
}
