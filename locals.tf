locals {
  # Components
  enable_dnssec        = var.dnssec_key_arn != null ? true : false
  enable_query_logging = var.enable_query_logging
  # Tagging
  common_tags = merge(
    {
      "terraform:module:repository" = "https://github.com/flagscript/terraform-aws-flagscript-dns"
      "terraform:module"            = "terraform-aws-flagscript-dns"
    },
    var.tags
  )

}
