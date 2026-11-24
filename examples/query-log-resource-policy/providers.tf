# The modules pin their region-sensitive resources to us-east-1, so the
# provider can be configured for any region.
provider "aws" {
  region = var.region
}
