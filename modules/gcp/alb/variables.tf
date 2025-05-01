variable "lb_name" {
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
variable "network" {
  description = "Name of the VPC network"
  type        = string
}

variable "target_tags" {
  description = "List of target tags for health check firewall rule"
  type        = list(string)
  default     = []
}

variable "backends" {
  description = "Map of backend configurations for the load balancer"
  type = map(object({
    protocol            = string
    port_name           = optional(string)
    description         = optional(string)
    enable_cdn          = optional(bool, false)
    timeout_sec         = optional(number, 30)
    
    log_config = optional(object({
      enable      = optional(bool, true)
      sample_rate = optional(number, 1.0)
    }))
    
    groups = list(object({
      group = string
    }))
    
    iap_config = optional(object({
      enable = optional(bool, false)
    }))
  }))
}
variable "create_serverless_neg" {
  description = "Whether to create a serverless NEG for Cloud Run"
  type        = bool
  default     = false
}

variable "serverless_neg_name" {
  description = "Name of the serverless NEG"
  type        = string
  default     = ""
}

variable "cloud_run_service_name" {
  description = "Name of the Cloud Run service to use as backend"
  type        = string
  default     = ""
}
variable "enable_ssl" {
  description = "Whether to enable SSL for the load balancer"
  type        = bool
  default     = false
}

variable "ssl_domains" {
  description = "List of domains for the SSL certificate"
  type        = list(string)
  default     = []
}

variable "https_redirect" {
  description = "Whether to redirect HTTP traffic to HTTPS"
  type        = bool
  default     = false
}

