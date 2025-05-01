output "instances_details" {
  description = "List of all details for compute instances"
  value       = module.compute_instance.instances_details
}

output "instances_self_links" {
  description = "List of self-links for compute instances"
  value       = module.compute_instance.instances_self_links
}

output "available_zones" {
  description = "List of available zones in the region"
  value       = module.compute_instance.available_zones
}

output "instances_names" {
  description = "Names of the instances"
  value       = module.compute_instance.instances_names
}

output "instances_service_accounts" {
  description = "Service accounts of the instances"
  value       = module.compute_instance.instances_service_accounts
}