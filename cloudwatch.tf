

# Cloudwatch
## Log Group
resource "aws_cloudwatch_log_group" "query_log_group" {
  count             = local.enable_query_logging ? 1 : 0
  region            = "us-east-1"
  log_group_class   = "STANDARD"
  name              = "/aws/route53/${var.zone_domain}"
  retention_in_days = var.log_retention_days

  tags = merge(
    local.common_tags,
    {
      "Name" = "/aws/route53/${var.zone_domain}"
    }
  )
}

## Query Logging
resource "aws_route53_query_log" "query_log" {
  count                    = local.enable_query_logging ? 1 : 0
  cloudwatch_log_group_arn = aws_cloudwatch_log_group.query_log_group[0].arn
  zone_id                  = aws_route53_zone.public_hosted_zone.zone_id
}
