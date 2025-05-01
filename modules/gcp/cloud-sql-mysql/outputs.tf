output "instance_name" {
  description = "The name of the Cloud SQL instance"
  value       = module.cloudsql.instance_name
}

output "instance_connection_name" {
  description = "The connection name of the Cloud SQL instance"
  value       = module.cloudsql.instance_connection_name
}

output "public_ip_address" {
  description = "The public IPv4 address of the Cloud SQL instance"
  value       = module.cloudsql.public_ip_address
}

output "private_ip_address" {
  description = "The private IPv4 address of the Cloud SQL instance"
  value       = module.cloudsql.private_ip_address
}

output "instance_first_ip_address" {
  description = "The first IPv4 address of the Cloud SQL instance"
  value       = module.cloudsql.instance_first_ip_address
}

output "instance_self_link" {
  description = "The URI of the Cloud SQL instance"
  value       = module.cloudsql.instance_self_link
}

