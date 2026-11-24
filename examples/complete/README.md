# Complete public hosted zone

Creates a Route 53 public hosted zone with DNSSEC signing and query logging, and the shared resources those features need. All of it is in a single account:

- a DNSSEC KMS key, from the [`dnssec-key`](../../modules/dnssec-key) submodule;
- the CloudWatch Logs resource policy for Route 53 query logging, from the [`query_log_resource_policy`](../../modules/query_log_resource_policy) submodule;
- the hosted zone, with a DNSSEC key-signing key, signing turned on, and query logs sent to `/aws/route53/<zone_domain>`.

In a multi-account AWS Organization, you would normally create the DNSSEC key once in a central account and deploy the resource policy once per account. Each hosted zone then only needs the root module.

## Prerequisites

- The account must belong to an AWS Organization, because the `dnssec-key` key policy is scoped to the organization ID.

## Usage

```bash
terraform init
terraform plan -var="zone_domain=example.com"
terraform apply -var="zone_domain=example.com"
```

After you apply:

1. Set the `public_hosted_zone_name_servers` output as the domain's name servers at your registrar.
2. Get the DS record for the key-signing key, from the Route 53 console or `aws route53 get-dnssec --hosted-zone-id <id>`, and add it at your registrar to complete the DNSSEC chain of trust.

To tear down, remove the DS record at your registrar first and wait for its TTL to expire. Then run `terraform destroy`. If you destroy the key while the DS record is still published, the domain will fail DNSSEC validation.

This example creates resources that cost money: the hosted zone, the KMS key and CloudWatch Logs storage.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.16 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.72 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.72 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_dns"></a> [dns](#module\_dns) | ../.. | n/a |
| <a name="module_dnssec_key"></a> [dnssec\_key](#module\_dnssec\_key) | ../../modules/dnssec-key | n/a |
| <a name="module_query_log_resource_policy"></a> [query\_log\_resource\_policy](#module\_query\_log\_resource\_policy) | ../../modules/query_log_resource_policy | n/a |

## Resources

| Name | Type |
| ---- | ---- |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_dnssec_key_name"></a> [dnssec\_key\_name](#input\_dnssec\_key\_name) | The name of the DNSSEC KMS key. | `string` | `"dnssec-example"` | no |
| <a name="input_dnssec_signing_status"></a> [dnssec\_signing\_status](#input\_dnssec\_signing\_status) | The DNSSEC signing status for the hosted zone: 'SIGNING' or 'NOT\_SIGNING'. | `string` | `"SIGNING"` | no |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | How many days to keep the query logs. | `number` | `30` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region for the provider. | `string` | `"us-east-1"` | no |
| <a name="input_zone_domain"></a> [zone\_domain](#input\_zone\_domain) | The domain name of the hosted zone to create. | `string` | `"example.com"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_dnssec_key_arn"></a> [dnssec\_key\_arn](#output\_dnssec\_key\_arn) | The ARN of the DNSSEC KMS key. |
| <a name="output_public_hosted_zone_id"></a> [public\_hosted\_zone\_id](#output\_public\_hosted\_zone\_id) | The ID of the public hosted zone. |
| <a name="output_public_hosted_zone_name_servers"></a> [public\_hosted\_zone\_name\_servers](#output\_public\_hosted\_zone\_name\_servers) | The name servers to set at your domain registrar. |
| <a name="output_public_hosted_zone_query_log_group_arn"></a> [public\_hosted\_zone\_query\_log\_group\_arn](#output\_public\_hosted\_zone\_query\_log\_group\_arn) | The ARN of the CloudWatch log group that receives the query logs. |
| <a name="output_query_log_resource_policy_id"></a> [query\_log\_resource\_policy\_id](#output\_query\_log\_resource\_policy\_id) | The ID of the CloudWatch Logs resource policy for Route 53 query logging. |
<!-- END_TF_DOCS -->
