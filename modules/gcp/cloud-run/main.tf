module "cloud_run" {
  source  = "GoogleCloudPlatform/cloud-run/google"
  version = "~> 0.17.0"
  # Required variables
  service_name = var.service_name
  project_id   = var.project_id
  location     = var.region
  image        = var.image
  # Resource allocation
  limits = {
    cpu    = var.cpu_limit
    memory = var.memory_limit
  }
  # Container configuration
  container_concurrency = var.container_concurrency
  timeout_seconds       = var.timeout_seconds
  # Port configuration
  ports = var.ports
  # Environment variables and secrets
  env_vars        = var.env_vars
  env_secret_vars = var.env_secret_vars

  service_account_email = var.service_account_email
  
  # VPC connector for private networking
  template_annotations = {
    "run.googleapis.com/health-check-disabled" = "true"
    # VPC Connector for SQL and other private services
    # "run.googleapis.com/vpc-access-connector" = var.vpc_connector_name
    "run.googleapis.com/network-interfaces" = jsonencode(var.network_interfaces)
    # Direct all traffic through VPC connector
    "run.googleapis.com/vpc-access-egress"    = "private-ranges-only"    #var.vpc_egress_setting
    # Cloud SQL connectivity
    # "run.googleapis.com/cloudsql-instances"   = var.cloudsql_connections
    # CPU allocation
    "run.googleapis.com/cpu-throttling"       = var.cpu_throttling 
    # Startup CPU boost
    "run.googleapis.com/startup-cpu-boost"    = var.startup_cpu_boost 
  }
  # IAM members who can access the service
  members = var.allow_public_access ? ["allUsers"] : var.members
}

