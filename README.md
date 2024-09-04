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
| [aws_cloudwatch_log_resource_policy.route53_query_logging_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_resource_policy) | resource |
| [aws_kms_alias.dnssec_key_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.dnssec_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key_policy.dnssec_signing_kms_key_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.dnssec_key_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.route53_query_logging_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dnssec_hosted_zone_ids"></a> [dnssec\_hosted\_zone\_ids](#input\_dnssec\_hosted\_zone\_ids) | List of hosted zones ids to use dnssec with. | `list(string)` | `[]` | no |
| <a name="input_dnssec_key_alias_arn"></a> [dnssec\_key\_alias\_arn](#input\_dnssec\_key\_alias\_arn) | The Amazon Resource Name (ARN) of the key alias. | `string` | n/a | yes |
| <a name="input_dnssec_key_alias_name"></a> [dnssec\_key\_alias\_name](#input\_dnssec\_key\_alias\_name) | The display name of the alias. | `string` | n/a | yes |
| <a name="input_dnssec_key_arn"></a> [dnssec\_key\_arn](#input\_dnssec\_key\_arn) | The Amazon Resource Name (ARN) of the key. | `string` | n/a | yes |
| <a name="input_dnssec_key_id"></a> [dnssec\_key\_id](#input\_dnssec\_key\_id) | The globally unique identifier for the key. | `string` | n/a | yes |
| <a name="input_enable_key_rotation"></a> [enable\_key\_rotation](#input\_enable\_key\_rotation) | Specifies whether dnsseckey rotation is enabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_hosted_zone_name"></a> [hosted\_zone\_name](#input\_hosted\_zone\_name) | The name of the hosted zone. | `string` | n/a | yes |
| <a name="input_key_deletion_window_in_days"></a> [key\_deletion\_window\_in\_days](#input\_key\_deletion\_window\_in\_days) | The waiting period, specified in number of days. Defaults to 7. | `number` | `7` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->