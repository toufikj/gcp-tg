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
  source = "../../../../modules/gcp/cloud-sql-mysql"
}

inputs = {
  project_id = include.root.locals.project_id
  region     = include.root.locals.region
  
  # Instance configuration
  instance_name = "elevatenow-mysql-${include.root.locals.environment}"
  database_version = "MYSQL_8_0"
  tier = "db-n1-standard-2"
  disk_size = 100
  disk_type = "PD_SSD"
  disk_autoresize = true
  disk_autoresize_limit = 0
  
  # Database configuration
  databases = [
    {
      name = "elevatenow_${include.root.locals.environment}"
      charset = "utf8mb4"
      collation = "utf8mb4_unicode_ci"
    }
  ]
  database_flags = [
    {
      name  = "max_connections"
      value = "1000"
    }
  ]
  user_labels = local.tags
  
  # Network configuration
  vpc_network = "projects/${include.root.locals.project_id}/global/networks/${dependency.vpc.outputs.network_name}"
  ipv4_enabled = true
  require_ssl = true
  authorized_networks = [
    {
      name  = "subnet-1"
      value = dependency.vpc.outputs.subnets_ips[1]
    },
    {
      name  = "subnet-2"
      value = dependency.vpc.outputs.subnets_ips[4]
    }
  ]
  allocated_ip_range = "elevatenow-prod-ip-range"
  
  # Backup configuration
  backup_configuration = {
    enabled                        = true
    start_time                     = "03:00"
    location                       = null
    point_in_time_recovery_enabled = true
    transaction_log_retention_days = 7
    retained_backups               = 7
    retention_unit                 = "COUNT"
  }
  
  # Maintenance configuration
  maintenance_window_day = 1
  maintenance_window_hour = 3
  maintenance_window_update_track = "stable"
  
  # User configuration
  user_name = "admin"
  #user_password = dependency.cloud_sql.outputs.admin_password
}

dependency "vpc" {
  config_path = "../vpc"  # Path to the vpc module
}
