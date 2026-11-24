# Central DNSSEC KMS key

Creates a DNSSEC KMS key in `us-east-1` with the [`dnssec-key`](../../modules/dnssec-key) submodule. Route 53 can use the key for any hosted zone in your AWS Organization.

Deploy it once, usually in a central DNS or security account. Then pass the `dnssec_key_arn` output to the root module's `dnssec_key_arn` input for each zone you want to sign.

## Prerequisites

- The account must belong to an AWS Organization, and the caller needs `organizations:DescribeOrganization`.

## Usage

```bash
terraform init
terraform plan
terraform apply
```

A KMS key costs a monthly fee plus a charge per request. Before you destroy the key, turn off DNSSEC on every zone that uses it and remove their DS records at the registrar.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.16 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.72 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_dnssec_key"></a> [dnssec\_key](#module\_dnssec\_key) | ../../modules/dnssec-key | n/a |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | The name of the DNSSEC KMS key. It is also used for the alias, alias/<key\_name>. | `string` | `"dnssec"` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region for the provider. | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_dnssec_key_alias_name"></a> [dnssec\_key\_alias\_name](#output\_dnssec\_key\_alias\_name) | The alias of the DNSSEC KMS key. |
| <a name="output_dnssec_key_arn"></a> [dnssec\_key\_arn](#output\_dnssec\_key\_arn) | The ARN of the DNSSEC KMS key. Pass it to the root module's dnssec\_key\_arn input. |
<!-- END_TF_DOCS -->
