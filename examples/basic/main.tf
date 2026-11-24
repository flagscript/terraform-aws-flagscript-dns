module "dns" {
  source = "../.."

  zone_domain = var.zone_domain

  tags = {
    "Environment" = "example"
  }
}
