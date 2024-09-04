data "aws_caller_identity" "current" {}
locals {
  current_account_id = data.aws_caller_identity.current.account_id
  common_tags = {
    "github:module:repository" = "flagscript/terraform-aws-flagscript-dns"
    "terraform:module"         = "terraform-aws-flagscript-dns"
  }

}
