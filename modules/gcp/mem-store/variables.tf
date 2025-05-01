variable "name" {
  description = "Name of the Memorystore instance"
  type        = string
}

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "Region where the Memorystore instance will be created"
  type        = string
}

variable "memory_size_gb" {
  description = "Memory size of the Redis instance in GB (1-300)"
  type        = number
  default     = 1
}

variable "enable_apis" {
  description = "Whether to enable required Google APIs"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "The self-link of the VPC network to connect Memorystore with"
  type        = string
}

variable "connect_mode" {
  description = "Connection mode for Redis - either DIRECT_PEERING or PRIVATE_SERVICE_ACCESS"
  type        = string
  default     = "PRIVATE_SERVICE_ACCESS"
}

variable "environment" {
  description = "Environment label (e.g., dev, staging, prod)"
  type        = string
}
variable "transit_encryption_mode" {
  description = "Transit encryption mode for Redis - either NONE or TLS"
  type        = string
}
