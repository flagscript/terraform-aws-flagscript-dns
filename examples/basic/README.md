# Basic public hosted zone

Creates a Route 53 public hosted zone without DNSSEC or query logging.

After you apply, delegate the domain by setting the `public_hosted_zone_name_servers` output as the domain's name servers at your registrar.

## Usage

```bash
terraform init
terraform plan -var="zone_domain=example.com"
terraform apply -var="zone_domain=example.com"
```

This example creates resources that cost money, such as the monthly charge for a hosted zone. Run `terraform destroy` when you no longer need them.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.16 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.72 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_dns"></a> [dns](#module\_dns) | ../.. | n/a |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_region"></a> [region](#input\_region) | The AWS region for the provider. | `string` | `"us-east-1"` | no |
| <a name="input_zone_domain"></a> [zone\_domain](#input\_zone\_domain) | The domain name of the hosted zone to create. | `string` | `"example.com"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_public_hosted_zone_id"></a> [public\_hosted\_zone\_id](#output\_public\_hosted\_zone\_id) | The ID of the public hosted zone. |
| <a name="output_public_hosted_zone_name_servers"></a> [public\_hosted\_zone\_name\_servers](#output\_public\_hosted\_zone\_name\_servers) | The name servers to set at your domain registrar. |
<!-- END_TF_DOCS -->
