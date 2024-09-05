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
| [aws_route53domains_delegation_signer_record.registered_domain_signer_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53domains_delegation_signer_record) | resource |
| [aws_route53domains_registered_domain.registered_domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53domains_registered_domain) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_privacy"></a> [admin\_privacy](#input\_admin\_privacy) | Whether domain administrative contact information is concealed from WHOIS queries. | `bool` | `true` | no |
| <a name="input_auto_renew"></a> [auto\_renew](#input\_auto\_renew) | Whether the domain registration is set to renew automatically. | `bool` | `true` | no |
| <a name="input_billing_privacy"></a> [billing\_privacy](#input\_billing\_privacy) | Whether domain billing contact information is concealed from WHOIS queries. | `bool` | `true` | no |
| <a name="input_dnssec_flag"></a> [dnssec\_flag](#input\_dnssec\_flag) | An integer that specifies how the key is used. For key-signing key (KSK), this value is always 257. | `string` | n/a | yes |
| <a name="input_dnssec_public_key"></a> [dnssec\_public\_key](#input\_dnssec\_public\_key) | The public key, represented as a Base64 encoding, as required by RFC-4034 Page 5. | `string` | n/a | yes |
| <a name="input_dnssec_signing_algorithm_type"></a> [dnssec\_signing\_algorithm\_type](#input\_dnssec\_signing\_algorithm\_type) | An integer used to represent the signing algorithm. This value must follow the guidelines provided by RFC-8624 Section 3.1. | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The name of the registered domain.. | `string` | n/a | yes |
| <a name="input_registrant_privacy"></a> [registrant\_privacy](#input\_registrant\_privacy) | Whether domain registrant contact information is concealed from WHOIS queries. | `bool` | `true` | no |
| <a name="input_tech_privacy"></a> [tech\_privacy](#input\_tech\_privacy) | Whether domain technical contact information is concealed from WHOIS queries. | `bool` | `true` | no |
| <a name="input_transfer_lock"></a> [transfer\_lock](#input\_transfer\_lock) | Whether the domain is locked for transfer. | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->