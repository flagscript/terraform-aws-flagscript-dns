data "aws_caller_identity" "current" {}

module "query_log_resource_policy" {
  source = "../../modules/query_log_resource_policy"

  # Covers every log group the root module creates (/aws/route53/<zone_domain>).
  hosted_zone_log_group_arns = [
    "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/route53/*",
  ]
}
