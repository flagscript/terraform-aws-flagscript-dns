<!-- BEGIN_TF_DOCS -->
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

## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.16 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.72 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.72 |

## Resources

| Name | Type |
| ---- | ---- |
| [aws_cloudwatch_log_group.query_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_route53_hosted_zone_dnssec.dnssec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_hosted_zone_dnssec) | resource |
| [aws_route53_key_signing_key.dnssec_signing_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_key_signing_key) | resource |
| [aws_route53_query_log.query_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_query_log) | resource |
| [aws_route53_zone.public_hosted_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_zone_domain"></a> [zone\_domain](#input\_zone\_domain) | The domain name of the hosted zone. | `string` | n/a | yes |
| <a name="input_dnssec_key_arn"></a> [dnssec\_key\_arn](#input\_dnssec\_key\_arn) | The Amazon Resource Name (ARN) of the dnssec KMS key. | `string` | `null` | no |
| <a name="input_dnssec_signing_status"></a> [dnssec\_signing\_status](#input\_dnssec\_signing\_status) | The status of the DNSSEC signing for the hosted zone. Defaults to 'NOT\_SIGNING'. | `string` | `"NOT_SIGNING"` | no |
| <a name="input_enable_query_logging"></a> [enable\_query\_logging](#input\_enable\_query\_logging) | Specifies whether to enable query logging for the hosted zone. Defaults to false. | `bool` | `false` | no |
| <a name="input_force_destroy_records"></a> [force\_destroy\_records](#input\_force\_destroy\_records) | Specifies whether to force destroy the records when deleting the zone. Defaults to false. | `bool` | `false` | no |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | How long to keep the domains query logs. | `number` | `7` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to merge into module tags. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_public_hosted_zone_arn"></a> [public\_hosted\_zone\_arn](#output\_public\_hosted\_zone\_arn) | The Amazon Resource Name (ARN) of the public hosted zone. |
| <a name="output_public_hosted_zone_domain"></a> [public\_hosted\_zone\_domain](#output\_public\_hosted\_zone\_domain) | The domain name of the public hosted zone. |
| <a name="output_public_hosted_zone_id"></a> [public\_hosted\_zone\_id](#output\_public\_hosted\_zone\_id) | The ID of the public hosted zone. |
| <a name="output_public_hosted_zone_name_servers"></a> [public\_hosted\_zone\_name\_servers](#output\_public\_hosted\_zone\_name\_servers) | The authoritative name servers for the public hosted zone. |
| <a name="output_public_hosted_zone_primary_name_server"></a> [public\_hosted\_zone\_primary\_name\_server](#output\_public\_hosted\_zone\_primary\_name\_server) | The primary authoritative name server for the public hosted zone. |
| <a name="output_public_hosted_zone_query_log_config_arn"></a> [public\_hosted\_zone\_query\_log\_config\_arn](#output\_public\_hosted\_zone\_query\_log\_config\_arn) | The ARN of the query log configuration for the public hosted zone. |
| <a name="output_public_hosted_zone_query_log_config_id"></a> [public\_hosted\_zone\_query\_log\_config\_id](#output\_public\_hosted\_zone\_query\_log\_config\_id) | The ID of the query log configuration for the public hosted zone. |
| <a name="output_public_hosted_zone_query_log_group_arn"></a> [public\_hosted\_zone\_query\_log\_group\_arn](#output\_public\_hosted\_zone\_query\_log\_group\_arn) | The ARN of the CloudWatch log group for the public hosted zone query logs. |

## Contributing

Commits follow [Conventional Commits](https://www.conventionalcommits.org/), which commitlint enforces through lefthook. Releases and the changelog are generated by semantic-release when changes merge to `main`.

The documentation tables above are generated by [terraform-docs](https://terraform-docs.io/) on pre-commit. To change the surrounding text, edit `docs/header.md` or `docs/footer.md` (or `modules/<name>/docs/header.md` for a submodule), not this README.

## License

MIT licensed. See [LICENSE](https://github.com/flagscript/terraform-aws-flagscript-dns/blob/main/LICENSE).
<!-- END_TF_DOCS -->