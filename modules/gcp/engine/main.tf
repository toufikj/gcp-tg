module "compute_instance" {
  source  = "terraform-google-modules/vm/google//modules/compute_instance"
  version = "~> 8.0"

  # Required variables
  project_id        = var.project_id
  region            = var.region
  zone              = var.zone
  hostname          = var.hostname
  instance_template = var.instance_template

  # Optional variables with defaults
  network           = var.network
  subnetwork        = var.subnetwork
  subnetwork_project = var.subnetwork_project
  num_instances     = var.num_instances
#   static_ips        = var.static_ips
  access_config     = var.access_config
  
  # Additional configuration
#   resource_policies = var.resource_policies
#   deletion_protection = var.deletion_protection
  
  # Labels and tags
  labels            = var.labels
  tags              = var.tags
}