locals {
  environment = "prod"
  brand = "toufik"

  tags = {
    environment = local.environment
    developer   = "toufik"
    brand = local.brand
  }
}