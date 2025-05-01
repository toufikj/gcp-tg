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
    component = "cloud-sql"
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
  source = "../../../../modules/gcp/artifacts"
}

inputs = {
  project_id = include.root.locals.project_id
  region     = include.root.locals.region
  repository_id = "prod-elevatenow-nextjs"
  format     = "DOCKER"
}