module "dnssec_key" {
  source = "../../modules/dnssec-key"

  key_name                    = var.key_name
  key_deletion_window_in_days = 30

  tags = {
    "Environment" = "example"
  }
}
