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
  source = "../../../../modules/gcp/mem-store"
}

inputs = {
  project_id = include.root.locals.project_id
  region     = include.root.locals.region
  environment = include.root.locals.environment
  name       = "elevatenow-${include.root.locals.environment}-memstore"
  vpc_id     = "elevatenow-${include.root.locals.environment}-vpc"
  memory_size_gb = 1
  enable_apis = "true"
  connect_mode = "PRIVATE_SERVICE_ACCESS"
  transit_encryption_mode = "DISABLED"
  
}