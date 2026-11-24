# Kms
## Key
resource "aws_kms_key" "dnssec_key" {
  region                             = "us-east-1"
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
      "Name"   = var.key_name
      "region" = "us-east-1"
    }
  )
}

## Alias
resource "aws_kms_alias" "dnssec_key_alias" {
  region        = "us-east-1"
  name          = "alias/${var.key_name}"
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
    sid = "EnableRootAccountAdmin"

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
    sid = "AllowRoute53DNSSECServiceForOrg"

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:route53:::hostedzone/*"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceOrgID"
      values   = [local.organization_id]
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
    sid = "AllowRoute53DNSSECCreateGrantForOrg"

    condition {
      test     = "StringEquals"
      variable = "aws:SourceOrgID"
      values   = [local.organization_id]
    }

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

  statement {
    actions = [
      "kms:CreateGrant",
      "kms:DescribeKey",
      "kms:GetPublicKey",
      "kms:Sign",
    ]
    effect = "Allow"
    resources = [
      "*",
    ]
    sid = "AllowSpokePrincipalsToCreateKSKs"

    condition {
      test     = "StringEquals"
      variable = "aws:SourceOrgID"
      values   = [local.organization_id]
    }

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
  region = "us-east-1"
  key_id = aws_kms_key.dnssec_key.key_id
  policy = data.aws_iam_policy_document.dnssec_key_policy_document.json
}
