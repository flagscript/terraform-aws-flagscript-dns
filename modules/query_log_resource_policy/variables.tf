# REQUIRED PARAMETERS
# These parameters must be supplied when consuming this module.
variable "hosted_zone_log_group_arns" {
  description = "The Amazon Resource Names (ARNs) of the CloudWatch log groups to which Route 53 will send query logs."
  type        = list(string)
}

# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
