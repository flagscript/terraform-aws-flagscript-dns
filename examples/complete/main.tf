data "aws_caller_identity" "current" {}

# Central DNSSEC KMS key. In a multi-account setup this usually lives in a
# shared DNS or security account and is created once.
module "dnssec_key" {
  source = "../../modules/dnssec-key"

  key_name = var.dnssec_key_name
}

# Account-wide CloudWatch Logs resource policy that lets Route 53 write query
# logs. A wildcard covers every log group the root module creates.
module "query_log_resource_policy" {
  source = "../../modules/query_log_resource_policy"

  hosted_zone_log_group_arns = [
    "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/route53/*",
  ]
}

module "dns" {
  source = "../.."

  zone_domain = var.zone_domain

  # DNSSEC
  dnssec_key_arn        = module.dnssec_key.dnssec_key_arn
  dnssec_signing_status = var.dnssec_signing_status

  # Query logging
  enable_query_logging = true
  log_retention_days   = var.log_retention_days

  tags = {
    "Environment" = "example"
  }

  # The resource policy must exist before Route 53 can create the query log configuration.
  depends_on = [module.query_log_resource_policy]
}
