variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "subnet_region" {
  description = "The region for subnets (defaults to the main region if not specified)"
  type        = string
  default     = ""
}

variable "network_name" {
  description = "The name of the VPC network"
  type        = string
  default     = "elevatenow-vpc"
}

variable "routing_mode" {
  description = "The network routing mode (GLOBAL or REGIONAL)"
  type        = string
  default     = "GLOBAL"
}

variable "subnet_prefix" {
  description = "Prefix to use for subnet names"
  type        = string
  default     = "elevatenow"
}

variable "subnet_cidrs" {
  description = "CIDR ranges for subnets"
  type        = object({
    public_01  = string
    private_01 = string
    public_02  = string
    private_02 = string
    public_03  = string
    private_03 = string
  })
  default     = {
    public_01  = "10.22.0.0/24"
    private_01 = "10.22.3.0/24"
    public_02  = "10.22.1.0/24"
    private_02 = "10.22.4.0/24"
    public_03  = "10.22.2.0/24"
    private_03 = "10.22.5.0/24"
  }
}

variable "routes" {
  description = "List of routes to be added to the VPC"
  type        = list(map(string))
  default     = [
    {
      name                   = "egress-internet"
      description            = "route through IGW to access internet"
      destination_range      = "0.0.0.0/0"
      tags                   = "egress-inet"
      next_hop_internet      = "true"
    },
    {
      name                   = "app-proxy"
      description            = "route through proxy to reach app"
      destination_range      = "10.22.0.0/24"
      tags                   = "app-proxy"
      next_hop_instance      = "app-proxy-instance"
      next_hop_instance_zone = "asia-south1-a"
    }
  ]
}

