variable "service_name" {
  description = "Name of the Cloud Run service"
  type        = string
}

variable "project_id" {
  description = "ID of the GCP project"
  type        = string
}

variable "region" {
  description = "Region where the Cloud Run service will be deployed"
  type        = string
}
variable "network_interfaces" {
  description = "Network interfaces configuration for direct VPC network connection"
  type = list(object({
    network    = string
    subnetwork = string
  }))
  default = []
}

variable "image" {
  description = "Docker image to use for the Cloud Run service"
  type        = string 
}
variable "cpu_limit" {
  description = "CPU limit for the Cloud Run service"
  type        = string
}

variable "memory_limit" {
  description = "Memory limit for the Cloud Run service"
  type        = string  
}
variable "container_concurrency" {
  description = "Concurrency limit for the Cloud Run service"
  type        = number
}
variable "timeout_seconds" {
  description = "Timeout for the Cloud Run service"
  type        = number
}

variable "ports" {
  description = "Port to expose on the Cloud Run service"
  type        = object({
    name          = string
    port          = number
  })
}
 
variable "min_instances" {
  description = "Minimum number of instances for the Cloud Run service"
  type        = number
}

variable "max_instances" {
  description = "Maximum number of instances for the Cloud Run service"
  type        = number
}

variable "env_vars" {
  description = "Environment variables for the Cloud Run service"
  type        = list(object({
    name  = string
    value = string 
  }))
}

variable "env_secret_vars" {
  description = "Secret environment variables for the Cloud Run service"
  type        = list(object({
    name = string
    value_from = set(object({
      secret_key_ref = map(string)
    }))
  }))
  default = []
}
variable "service_account_email" {
  description = "Service account email to use for the Cloud Run service"
  type        = string
  default     = ""
}

variable "vpc_egress_setting" {
  description = "VPC egress setting: 'private-ranges-only' or 'all-traffic'"
  type        = string
}

# variable "cloudsql_connections" {
#   description = "Cloud SQL connection strings in the format: 'project:region:instance'"
#   type        = string
#   default     = ""
# }

variable "cpu_throttling" {
  description = "Whether to enable CPU throttling (true/false)"
  type        = bool
  default     = false
}

variable "startup_cpu_boost" {
  description = "Whether to enable CPU boost during container startup (true/false)"
  type        = bool
  default     = true
}

variable "allow_public_access" {
  description = "Allow unauthenticated access to the Cloud Run service"
  type        = bool
  default     = false
}

variable "members" {
  description = "IAM members who can access the service"
  type        = list(string)
  default     = []
}
# variable "template_annotations" {
#   description = "Annotations to set on the Cloud Run service template"
#   type        = map(string)
#   default     = {}
# }

# variable "create_load_balancer" {
#   description = "Whether to create a load balancer for the Cloud Run service"
#   type        = bool
# }

# variable "lb_labels" {
#   description = "Whether to enable SSL for the load balancer"
#   type        = bool
# }

# variable "domains" {
#   description = "List of domains for the SSL certificate"
#   type        = list(string)
# }

# variable "enable_cdn" {
#   description = "Whether to enable CDN for the load balancer"
#   type        = bool
#   default     = false
# }

# variable "enable_iap" {
#   description = "Whether to enable Identity-Aware Proxy for the load balancer"
#   type        = bool
# }

# variable "security_policy" {
#   description = "Security policy (Cloud Armor) to apply to the load balancer"
#   type        = string
#   default     = null
# }