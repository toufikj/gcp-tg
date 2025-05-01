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
    component = "alb"
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
  source = "../../../../modules/gcp/alb"
}

inputs = {
  project_id = include.root.locals.project_id
  region     = include.root.locals.region
  lb_name    = "nextjs-lb"
  network    = "${dependency.vpc.outputs.network_name}"
  # Service configuration
  backends = {
    default = {
      port        = 3000
      protocol    = "HTTP"
      port_name   = "http"
      description = "Backend for  application"
      enable_cdn  = false
      timeout_sec = 30
      
      # health_check = {
      #   request_path = "/health"
      #   port         = 8080
      # }
      
      log_config = {
        enable      = true
        sample_rate = 1.0
      }
      
      groups = [
        {
           group = "projects/${include.root.locals.project_id}/regions/${include.root.locals.region}/networkEndpointGroups/nextjs-neg"
        }
      ]
      
      iap_config = {
        enable = false
      }
    }
  }
  create_serverless_neg = true
  serverless_neg_name = "nextjs-neg"
  cloud_run_service_name = dependency.cloud_run.outputs.service_name
  # SSL configuration (optional)
  enable_ssl = false
  ssl_domains = []
  https_redirect = false
}


dependency "cloud_run" {
  config_path = "../run-nextjs"
  mock_outputs = {
    service_name  = "prod-nextjs"
  }
}
dependency "vpc" {
  config_path = "../vpc"  # Path to the vpc module
}
