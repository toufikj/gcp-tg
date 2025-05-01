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
    Component = "vpc"
  }

  tags = merge(include.root.locals.root_tags, include.stage.locals.tags, local.local_tags)
}

generate "provider_global" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "gcs" {}
  required_version = "${include.root.locals.version_terraform}"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "${include.root.locals.version_provider_google}"
    }
  }
}

provider "google" {
  project = "${include.root.locals.project_id}"
  region  = "${include.root.locals.region}"
}
EOF
}

terraform {
  source = "../../../../modules/gcp/vpc"
}

inputs = {
  project_id = include.root.locals.project_id
  region     = include.root.locals.region
  network_name = "${include.root.locals.environment}-vpc"
  subnet_prefix = "${include.root.locals.environment}"
  routing_mode = "GLOBAL"
  
  subnet_region = include.root.locals.region
  subnet_cidrs = {
    public_01  = "10.22.0.0/24"
    public_02  = "10.22.1.0/24"
    public_03  = "10.22.2.0/24"
    private_01 = "10.22.3.0/24"
    private_02 = "10.22.4.0/24"
    private_03 = "10.22.5.0/24"
  }
  
  tags = local.tags
}