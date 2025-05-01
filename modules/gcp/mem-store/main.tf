module "memorystore" {
  source  = "terraform-google-modules/memorystore/google"
  version = "~> 14.0"

  name           = var.name
  project_id     = var.project_id
  memory_size_gb = var.memory_size_gb
  enable_apis    = var.enable_apis
  region         = var.region  

  authorized_network = var.vpc_id  # VPC network self-link (not name)
  connect_mode       = var.connect_mode
  transit_encryption_mode = var.transit_encryption_mode

  labels = {
    env     = var.environment
    team    = "devops"
    project = var.project_id
  }
}