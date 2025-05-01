include "root" {
  path   = find_in_parent_folders("root-config.hcl")
  expose = true
}

include "stage" {
  path   = find_in_parent_folders("prod.hcl")
  expose = true
}

locals {
  # merge tags
  local_tags = {
    component = "cloud-run"
  }

  tags = merge(include.root.locals.root_tags, include.stage.locals.tags, local.local_tags)
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "gcs" {}
}

provider "google" {
  project = "${include.root.locals.project_id}"
  region  = "${include.root.locals.region}"
}
EOF
}


terraform {
  source = "../../../../modules/gcp/cloud-run"
}

inputs = {
  project_id = include.root.locals.project_id
  region     = include.root.locals.region
  
  # Service configuration
  service_name = "${include.root.locals.environment}-nextjs"
  image        = "metabase/metabase"
  network_interfaces = [
    {
      network    = dependency.vpc.outputs.network_id
      subnetwork = dependency.vpc.outputs.subnets_ids[0]
    }
  ]
  # Resource allocation
  cpu_limit    = "2"
  memory_limit = "2Gi"
  
  # Container configuration
  container_concurrency = 80
  timeout_seconds       = 300
  ports = {
    name = "http1", 
    port = 3000
  }
  
  # Scaling configuration
  min_instances = 1
  max_instances = 10
  
  # Environment variables
  env_vars = [
  {
    name  = "NODE_ENV"
    value = "prod"
  }
]
  env_secret_vars = []
  service_account_email = "toufik@terragrunt-demo-455612.iam.gserviceaccount.com"
  
  # VPC and SQL connectivity
  # vpc_connector_name = "projects/your-project/locations/your-region/connectors/your-connector"
  vpc_egress_setting = "all-traffic"
  # cloudsql_connections = ""
  
  # Performance settings
  cpu_throttling = true
  startup_cpu_boost = true
  allow_public_access = true
  # Access control
  # members = [
  #   "serviceAccount:your-service-account@project-id.iam.gserviceaccount.com",
  #   "user:user@example.com"
  # ]
}
dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    network_id = "default"
    subnets_ids = ["default-subnet-1", "default-subnet-2"]
  }
} 
