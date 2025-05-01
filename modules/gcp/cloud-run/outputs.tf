# output "cloud_run_url" {
#   value       = google_cloud_run_v2_service.default.status[0].url
#   description = "Cloud Run service URL"
# }
output "service_name" {
  value       = module.cloud_run.service_name
  description = "The name of the Cloud Run service"
}

output "service_url" {
  value       = module.cloud_run.service_url
  description = "The URL of the Cloud Run service"
}

output "service_status" {
  value       = module.cloud_run.service_status
  description = "The status of the Cloud Run service"
}

output "service_id" {
  value       = module.cloud_run.service_id
  description = "The ID of the Cloud Run service"
}
