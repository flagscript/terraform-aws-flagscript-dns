# Route 53 query logging resource policy

Creates the CloudWatch Logs resource policy that lets Route 53 write DNS query logs, using the [`query_log_resource_policy`](../../modules/query_log_resource_policy) submodule.

Deploy it once per account before any hosted zone that sets `enable_query_logging = true`. The policy uses a wildcard ARN, so it covers every `/aws/route53/*` log group in `us-east-1` and does not need updating when you add zones.

## Usage

```bash
terraform init
terraform plan
terraform apply
```

CloudWatch Logs allows only a limited number of resource policies per region, and this policy has a fixed name. Create only one per account.

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
| <a name="module_query_log_resource_policy"></a> [query\_log\_resource\_policy](#module\_query\_log\_resource\_policy) | ../../modules/query_log_resource_policy | n/a |

## Resources

| Name | Type |
| ---- | ---- |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_region"></a> [region](#input\_region) | The AWS region for the provider. | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_resource_policy_id"></a> [resource\_policy\_id](#output\_resource\_policy\_id) | The ID of the CloudWatch Logs resource policy for Route 53 query logging. |
<!-- END_TF_DOCS -->
