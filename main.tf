# Kms
## Key
resource "aws_kms_key" "dnssec_key" {
  bypass_policy_lockout_safety_check = false
  customer_master_key_spec           = "ECC_NIST_P256"
  deletion_window_in_days            = var.key_deletion_window_in_days
  description                        = "Dnssec signing key."
  enable_key_rotation                = var.enable_key_rotation
  is_enabled                         = true
  key_usage                          = "SIGN_VERIFY"
  multi_region                       = false
  tags = merge(
    local.common_tags,
    {
      "name" = "dnssec"
    }
  )
}

## Alias
resource "aws_kms_alias" "dnssec_key_alias" {
  name          = "alias/dnssec"
  target_key_id = aws_kms_key.dnssec_key.arn
}

## Key Policy
data "aws_iam_policy_document" "dnssec_key_policy_document" {
  statement {
    actions = [
      "kms:*"
    ]
    effect = "Allow"
    resources = [
      "*",
    ]
    sid = "Enable IAM policies"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.current_account_id}:root"]
    }
  }
  statement {
    actions = [
      "kms:DescribeKey",
      "kms:GetPublicKey",
      "kms:Sign",
    ]
    effect = "Allow"
    resources = [
      "*",
    ]
    sid = "Allow Route 53 DNSSEC Service"

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [local.current_account_id]
    }
    dynamic "condition" {
      for_each = length(var.dnssec_hosted_zone_ids) > 0 ? ["enable-dnssec"] : []
      content {
        test     = "ArnLike"
        variable = "aws:SourceArn"
        values   = formatlist("arn:aws:route53:::hostedzone/%s", var.dnssec_hosted_zone_ids)
      }
    }
    principals {
      type        = "Service"
      identifiers = ["dnssec-route53.amazonaws.com"]
    }
  }
  statement {
    actions = [
      "kms:CreateGrant",
    ]
    effect = "Allow"
    resources = [
      "*",
    ]
    sid = "Allow Route 53 DNSSEC Service to CreateGrant"

    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = ["true"]
    }
    principals {
      type        = "Service"
      identifiers = ["dnssec-route53.amazonaws.com"]
    }
  }
}

resource "aws_kms_key_policy" "dnssec_signing_kms_key_policy" {
  key_id = aws_kms_key.dnssec_key.key_id
  policy = data.aws_iam_policy_document.dnssec_key_policy_document.json
}

# Route 53
## Query Log Resource Policy
data "aws_iam_policy_document" "route53_query_logging_policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["arn:aws:logs:*:*:log-group:/aws/route53/*"]
    sid       = "Ruote53LogPolicy"

    principals {
      identifiers = ["route53.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "route53_query_logging_policy" {
  policy_document = data.aws_iam_policy_document.route53_query_logging_policy.json
  policy_name     = "route53-query-logging-policy"
}
