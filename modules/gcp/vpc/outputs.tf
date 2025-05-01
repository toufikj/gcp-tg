output "network" {
  description = "The created VPC network"
  value       = module.vpc.network
}

output "network_name" {
  description = "The name of the VPC network"
  value       = module.vpc.network_name
}

output "network_id" {
  description = "The ID of the VPC network"
  value       = module.vpc.network_id
}

output "subnets" {
  description = "A map of subnet resources (name = self_link)"
  value       = module.vpc.subnets
}

output "subnets_ids" {
  description = "A map of subnet IDs (name = id)"
  value       = module.vpc.subnets_ids
}

output "subnets_names" {
  description = "A list of subnet names"
  value       = module.vpc.subnets_names
}

output "subnets_regions" {
  description = "A map of subnet regions (name = region)"
  value       = module.vpc.subnets_regions
}

output "subnets_ips" {
  description = "A map of subnet IPs (name = ip_cidr_range)"
  value       = module.vpc.subnets_ips
}

output "routes" {
  description = "The routes configuration provided to the module"
  value       = var.routes
}