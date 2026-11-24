# query_log_resource_policy

Creates the CloudWatch Logs resource policy that lets Amazon Route 53 write DNS query logs to CloudWatch log groups.

Route 53 query logging needs a resource policy that lets the `route53.amazonaws.com` service principal call `logs:CreateLogStream` and `logs:PutLogEvents` on the target log groups. Without it, creating a query logging configuration fails. This module creates that policy, named `route53-query-logging-policy`, in `us-east-1`, the only region Route 53 query logging supports.

## Usage

Deploy this module once per account, before any hosted zone that has query logging turned on. A wildcard ARN covers every log group created by the root module, which names them `/aws/route53/<zone_domain>`:

```hcl
data "aws_caller_identity" "current" {}

module "query_log_resource_policy" {
  source  = "flagscript/flagscript-dns/aws//modules/query_log_resource_policy"
  version = "~> 2.0"

  hosted_zone_log_group_arns = [
    "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/route53/*",
  ]
}

module "dns" {
  source  = "flagscript/flagscript-dns/aws"
  version = "~> 2.0"

  zone_domain          = "example.com"
  enable_query_logging = true

  depends_on = [module.query_log_resource_policy]
}
```

## Notes

- CloudWatch Logs allows a limited number of resource policies per region (currently 10 per account), so use one shared policy with a wildcard rather than one policy per zone.
- The policy name is fixed, so create only one instance of this module per account.
