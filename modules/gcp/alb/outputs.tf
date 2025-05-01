# output "cloud_run_url" {
#   value       = google_cloud_run_v2_service.default.status[0].url
#   description = "Cloud Run service URL"
# }
output "load_balancer_ip" {
  value       = module.lb-http.external_ip
  description = "The external IP address of the load balancer"
}

output "backend_services" {
  value       = module.lb-http.backend_services
  description = "The backend services created for the load balancer"
}

output "url_map" {
  value       = module.lb-http.url_map
  description = "The URL map resource"
}

output "serverless_neg_id" {
  value       = var.create_serverless_neg ? google_compute_region_network_endpoint_group.serverless_neg[0].id : null
  description = "The ID of the serverless NEG for Cloud Run (if created)"
}

output "https_proxy" {
  value       = var.enable_ssl ? module.lb-http.https_proxy : null
  description = "The HTTPS proxy used by the load balancer (if SSL is enabled)"
}