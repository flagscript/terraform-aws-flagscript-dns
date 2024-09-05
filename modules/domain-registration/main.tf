resource "aws_route53domains_registered_domain" "registered_domain" {
  admin_privacy      = var.admin_privacy
  auto_renew         = var.auto_renew
  billing_privacy    = var.billing_privacy
  domain_name        = var.domain_name
  registrant_privacy = var.registrant_privacy
  tech_privacy       = var.tech_privacy
  transfer_lock      = var.transfer_lock

  tags = merge(
    local.common_tags,
    {
      name = var.domain_name
    }
  )
}

resource "aws_route53domains_delegation_signer_record" "registered_domain_signer_record" {
  domain_name = var.domain_name

  signing_attributes {
    algorithm  = var.dnssec_signing_algorithm_type
    flags      = var.dnssec_flag
    public_key = var.dnssec_public_key
  }
}
