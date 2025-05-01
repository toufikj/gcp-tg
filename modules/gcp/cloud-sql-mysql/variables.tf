variable "project_id" {
  description = "The project ID to deploy to"
  type        = string
}

variable "region" {
  description = "The region to deploy to"
  type        = string
}

variable "instance_name" {
  description = "The name of the Cloud SQL instance"
  type        = string
}

variable "database_version" {
  description = "The database version to use"
  type        = string
  default     = "MYSQL_8_0"
}


variable "vpc_network" {
  description = "The VPC network to use"
  type        = string
}

# variable "private_network" {
#   description = "The VPC network to use for private IP"
#   type        = string
# }

variable "allocated_ip_range" {
  description = "The name of the allocated IP range for the private IP CloudSQL instance"
  type        = string
  default     = null
}

# Instance configuration
variable "tier" {
  description = "The machine tier (First Generation) or type (Second Generation)"
  type        = string
  default     = "db-f1-micro"
}

variable "disk_size" {
  description = "The disk size in GB"
  type        = number
  default     = 10
}

variable "disk_type" {
  description = "The disk type"
  type        = string
  default     = "PD_SSD"
}

variable "disk_autoresize" {
  description = "Configuration to increase storage size automatically"
  type        = bool
  default     = true
}

variable "disk_autoresize_limit" {
  description = "The maximum size to which storage can be auto increased"
  type        = number
  default     = 0
}

# Database configuration
variable "database_flags" {
  description = "The database flags for the instance"
  type        = list(map(string))
  default     = []
}

variable "user_labels" {
  description = "The key/value labels for the instance"
  type        = map(string)
  default     = {}
}

# Backup configuration
variable "backup_configuration" {
  description = "The backup configuration for the instance"
  type = object({
    enabled                        = bool
    start_time                     = string
    location                       = string
    point_in_time_recovery_enabled = bool
    transaction_log_retention_days = number
    retained_backups               = number
    retention_unit                 = string
  })
  default = {
    enabled                        = true
    start_time                     = "03:00"
    location                       = null
    point_in_time_recovery_enabled = false
    transaction_log_retention_days = 7
    retained_backups               = 7
    retention_unit                 = "COUNT"
  }
}

# Maintenance configuration
variable "maintenance_window_day" {
  description = "The day of week (1-7) for the maintenance window"
  type        = number
  default     = 1
}

variable "maintenance_window_hour" {
  description = "The hour of day (0-23) maintenance window"
  type        = number
  default     = 3
}

variable "maintenance_window_update_track" {
  description = "The update track of maintenance window"
  type        = string
  default     = "stable"
}

# User configuration
variable "user_name" {
  description = "The name of the default user"
  type        = string
  default     = "default"
}

# Database configuration
variable "databases" {
  description = "The databases to create"
  type = list(object({
    name      = string
    charset   = string
    collation = string
  }))
  default = []
}

# IP configuration
variable "ipv4_enabled" {
  description = "Whether the instance should be assigned a public IPv4 address"
  type        = bool
  default     = false
}

variable "require_ssl" {
  description = "Whether SSL connections are required"
  type        = bool
  default     = true
}

variable "authorized_networks" {
  description = "List of authorized networks"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
} 