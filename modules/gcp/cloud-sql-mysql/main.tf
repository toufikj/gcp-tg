module "cloudsql" {
  source  = "terraform-google-modules/sql-db/google//modules/mysql"
  version = "~> 25.2"

  project_id = var.project_id
  region     = var.region
  name       = var.instance_name
  database_version = var.database_version

  # Instance configuration
  tier = var.tier
  disk_size = var.disk_size
  disk_type = var.disk_type
  disk_autoresize = var.disk_autoresize
  disk_autoresize_limit = var.disk_autoresize_limit

  # Database configuration
  database_flags = var.database_flags
  user_labels = var.user_labels
  db_name = var.databases[0].name

  # Backup configuration
  backup_configuration = var.backup_configuration

  # Maintenance configuration
  maintenance_window_day = var.maintenance_window_day
  maintenance_window_hour = var.maintenance_window_hour
  maintenance_window_update_track = var.maintenance_window_update_track

  # User configuration
  user_name = var.user_name
  # user_password = var.user_password

  # IP configuration
  ip_configuration = {
    ipv4_enabled    = var.ipv4_enabled
    private_network = var.vpc_network
    require_ssl     = var.require_ssl
    # authorized_networks = var.authorized_networks
    allocated_ip_range = var.allocated_ip_range
  }
} 