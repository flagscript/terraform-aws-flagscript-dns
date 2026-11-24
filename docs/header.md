# terraform-aws-flagscript-dns

Terraform module that creates an Amazon Route 53 public hosted zone, with optional DNSSEC signing and optional DNS query logging to CloudWatch Logs.

## Features

- **Public hosted zone**: creates the zone and tags it with the module's common tags plus your own.
- **DNSSEC (optional)**: if you pass `dnssec_key_arn`, the module creates a key-signing key (KSK) from that KMS key and manages the zone's DNSSEC signing status.
- **Query logging (optional)**: if you set `enable_query_logging`, the module creates a CloudWatch log group named `/aws/route53/<zone_domain>` in `us-east-1` and turns on Route 53 query logging for the zone.

Route 53 only accepts DNSSEC KMS keys and query log groups from `us-east-1`. The module sets `region = "us-east-1"` on those resources, so you can use it from a provider configured for any region.

## Submodules

| Submodule | Purpose |
|-----------|---------|
| [`dnssec-key`](https://github.com/flagscript/terraform-aws-flagscript-dns/tree/main/modules/dnssec-key) | Central DNSSEC KMS key for an AWS Organization. Pass its `dnssec_key_arn` output to this module. |
| [`query_log_resource_policy`](https://github.com/flagscript/terraform-aws-flagscript-dns/tree/main/modules/query_log_resource_policy) | CloudWatch Logs resource policy that lets Route 53 write query logs. Required once per account before you enable query logging. |

## Usage

### Basic hosted zone

```hcl
module "dns" {
  source  = "flagscript/flagscript-dns/aws"
  version = "~> 2.0"

  zone_domain = "example.com"
}
```

### Hosted zone with DNSSEC and query logging

```hcl
module "dnssec_key" {
  source  = "flagscript/flagscript-dns/aws//modules/dnssec-key"
  version = "~> 2.0"
}

module "query_log_resource_policy" {
  source  = "flagscript/flagscript-dns/aws//modules/query_log_resource_policy"
  version = "~> 2.0"

  hosted_zone_log_group_arns = [
    "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/route53/*",
  ]
}

module "dns" {
  source  = "flagscript/flagscript-dns/aws"
  version = "~> 2.0"

  zone_domain = "example.com"

  dnssec_key_arn        = module.dnssec_key.dnssec_key_arn
  dnssec_signing_status = "SIGNING"

  enable_query_logging = true
  log_retention_days   = 30

  depends_on = [module.query_log_resource_policy]
}

data "aws_caller_identity" "current" {}
```

## Enabling DNSSEC

1. Create a DNSSEC KMS key, for example with the `dnssec-key` submodule, and pass its ARN as `dnssec_key_arn`. The module creates the KSK and leaves `dnssec_signing_status` at its default of `NOT_SIGNING`.
2. Set `dnssec_signing_status = "SIGNING"` and apply again.
3. Get the DS record for the KSK, from the Route 53 console or `aws route53 get-dnssec`, and add it at your domain registrar or parent zone to complete the chain of trust.

To turn DNSSEC off safely, remove the DS record from the parent first, wait for its TTL to expire, then set `dnssec_signing_status = "NOT_SIGNING"`.

## Enabling query logging

Route 53 needs a CloudWatch Logs resource policy before it can write to the log group. Without one, creating `aws_route53_query_log` fails. Deploy the `query_log_resource_policy` submodule once per account, and use a wildcard ARN such as `log-group:/aws/route53/*` so the policy covers every zone this module creates. CloudWatch Logs allows a limited number of resource policies per region, so share one policy rather than creating one per zone.
