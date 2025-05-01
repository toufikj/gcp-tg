locals {
  # Common configurations
  project_id = "terragrunt-demo-455612"
  region     = "asia-south1"
  
  # Environment specific configurations
  environment = "prod"
  
  # Common tags
  root_tags = {
    environment = local.environment
    managedby   = "terraform"
    project     = "terragrunt-demo"
  }

  # Provider versions
  version_terraform = ">= 1.0.0"
  version_provider_google = "~> 4.0"
}

remote_state {
  backend = "gcs"
  config = {
    project  = local.project_id
    location = local.region
    bucket   = "terragunt-demo"
    prefix   = "${path_relative_to_include()}/state"
  }
}

terraform {
  after_hook "after_hook_plan" {
      commands     = ["plan"]
      execute      = ["sh", "-c", "terraform show -json tfplan.binary | jq > ${get_parent_terragrunt_dir("root")}/plan.json"]
  }
}