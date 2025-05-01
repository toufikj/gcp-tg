variable "project_id" {
  description = "The ID of the project where this VM will be created"
  type        = string
}

variable "region" {
  description = "The region where the VM will be created"
  type        = string
}

variable "zone" {
  description = "The zone where the VM will be created"
  type        = string
}

variable "hostname" {
  description = "Hostname of instances"
  type        = string
}

variable "instance_template" {
  description = "Instance template self_link used to create compute instances"
  type        = string
}

variable "network" {
  description = "Network to deploy to. Only one of network or subnetwork should be specified"
  type        = string
  default     = ""
}

variable "subnetwork" {
  description = "Subnet to deploy to. Only one of network or subnetwork should be specified"
  type        = string
  default     = ""
}

variable "subnetwork_project" {
  description = "The project that subnetwork belongs to"
  type        = string
  default     = ""
}

variable "num_instances" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

# variable "static_ips" {
#   description = "List of static IPs for VM instances"
#   type        = list(string)
#   default     = []
# }

variable "access_config" {
  description = "Access configurations, i.e. IPs via which the VM instance can be accessed via the Internet"
  type = list(object({
    nat_ip       = string
    network_tier = string
  }))
  default = []
}

# variable "resource_policies" {
#   description = "A list of resource policy names to be attached to the instance"
#   type        = list(string)
#   default     = []
# }

# variable "deletion_protection" {
#   description = "Enable deletion protection on this instance"
#   type        = bool
#   default     = false
# }

variable "labels" {
  description = "Labels to be attached to the VM instances"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Network tags to attach to the instance"
  type        = list(string)
  default     = []
}