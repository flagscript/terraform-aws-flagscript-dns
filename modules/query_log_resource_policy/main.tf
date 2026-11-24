data "aws_iam_policy_document" "route53_query_logging_policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    effect    = "Allow"
    resources = var.hosted_zone_log_group_arns
    sid       = "AllowRoute53QueryLoggingToCloudWatchLogs"

    principals {
      identifiers = [
        "route53.amazonaws.com"
      ]
      type = "Service"
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "route53_query_logging_policy" {
  region          = "us-east-1"
  policy_document = data.aws_iam_policy_document.route53_query_logging_policy.json
  policy_name     = "route53-query-logging-policy"
}
