locals {
  # AWs 
  current_account_id = data.aws_caller_identity.current.account_id
  organization_id    = data.aws_organizations_organization.current.id
  # Tags
  common_tags = merge(
    {
      "terraform:module:repository" = "https://github.com/flagscript/terraform-aws-flagscript-dns/tree/main/modules/dnssec-key"
      "terraform:module"            = "terraform-aws-flagscript-dns//modules/dnssec-key"
    },
    var.tags
  )
}
