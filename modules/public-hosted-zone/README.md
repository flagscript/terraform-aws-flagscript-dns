<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.60 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.60 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.query_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_route53_hosted_zone_dnssec.dnssec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_hosted_zone_dnssec) | resource |
| [aws_route53_key_signing_key.dnssec_signing_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_key_signing_key) | resource |
| [aws_route53_query_log.query_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_query_log) | resource |
| [aws_route53_zone.public_hosted_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_route53domains_delegation_signer_record.registered_domain_signer_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53domains_delegation_signer_record) | resource |
| [aws_route53domains_registered_domain.registered_domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53domains_registered_domain) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_privacy"></a> [admin\_privacy](#input\_admin\_privacy) | Whether domain administrative contact information is concealed from WHOIS queries. | `bool` | `true` | no |
| <a name="input_auto_renew"></a> [auto\_renew](#input\_auto\_renew) | Whether the domain registration is set to renew automatically. | `bool` | `true` | no |
| <a name="input_billing_privacy"></a> [billing\_privacy](#input\_billing\_privacy) | Whether domain billing contact information is concealed from WHOIS queries. | `bool` | `true` | no |
| <a name="input_dnssec_key_arn"></a> [dnssec\_key\_arn](#input\_dnssec\_key\_arn) | The Amazon Resource Name (ARN) of the dnssec key. | `string` | n/a | yes |
| <a name="input_hosted_zone_name"></a> [hosted\_zone\_name](#input\_hosted\_zone\_name) | The name of the hosted zone. | `string` | n/a | yes |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | The number of days you want to retain log events in the specified log group. | `number` | `30` | no |
| <a name="input_registrant_privacy"></a> [registrant\_privacy](#input\_registrant\_privacy) | Whether domain registrant contact information is concealed from WHOIS queries. | `bool` | `true` | no |
| <a name="input_tech_privacy"></a> [tech\_privacy](#input\_tech\_privacy) | Whether domain technical contact information is concealed from WHOIS queries. | `bool` | `true` | no |
| <a name="input_transfer_lock"></a> [transfer\_lock](#input\_transfer\_lock) | Whether the domain is locked for transfer. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon Resource Name (ARN) of the Hosted Zone. |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | The domain name associated with the hosted zone. |
| <a name="output_name_servers"></a> [name\_servers](#output\_name\_servers) | A list of name servers in associated (or default) delegation set. Find more about delegation sets in AWS docs. |
| <a name="output_primary_name_server"></a> [primary\_name\_server](#output\_primary\_name\_server) | The Route 53 name server that created the SOA record. |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | The Hosted Zone ID. This can be referenced by zone records. |
<!-- END_TF_DOCS -->