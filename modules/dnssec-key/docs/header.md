# dnssec-key

Creates a customer managed KMS key for Route 53 DNSSEC signing, intended to be shared by the hosted zones in an AWS Organization.

## Features

- An asymmetric `ECC_NIST_P256` key with `SIGN_VERIFY` usage, which Route 53 requires for DNSSEC key-signing keys.
- The key is created in `us-east-1`, the only region Route 53 accepts for DNSSEC keys, whatever region your provider is configured for.
- An alias, `alias/<key_name>`.
- A key policy that:
  - gives the owning account's root principal full administrative access;
  - lets the `dnssec-route53.amazonaws.com` service principal use the key (`DescribeKey`, `GetPublicKey`, `Sign`, `CreateGrant`), but only for requests coming from your AWS Organization (`aws:SourceOrgID`).

## Requirements

- Run it in an account that belongs to an AWS Organization. The module looks up the organization ID with `aws_org_organization`, so the caller needs `organizations:DescribeOrganization`.

## Usage

```hcl
module "dnssec_key" {
  source  = "flagscript/flagscript-dns/aws//modules/dnssec-key"
  version = "~> 2.0"

  key_name                    = "dnssec"
  key_deletion_window_in_days = 30
}

module "dns" {
  source  = "flagscript/flagscript-dns/aws"
  version = "~> 2.0"

  zone_domain    = "example.com"
  dnssec_key_arn = module.dnssec_key.dnssec_key_arn
}
```

## Notes

- Deleting this key breaks DNSSEC validation for every zone that signs with it, and resolvers will return `SERVFAIL` for those zones. Disable DNSSEC on those zones, and remove their DS records from the parent, before you destroy the key.
- `enable_key_rotation` is off by default. AWS KMS does not support automatic rotation for asymmetric keys, so rotate a DNSSEC KSK by creating a new key and KSK alongside the old one.
