module "lb-http" {
  source            = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version           = "~> 9.0"

  project           = var.project_id
  name              = var.lb_name
  network           = var.network

  ssl                             = var.enable_ssl
  managed_ssl_certificate_domains = var.ssl_domains
  https_redirect                  = var.https_redirect
  
  backends = var.backends
  depends_on = [google_compute_region_network_endpoint_group.serverless_neg]
}

resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  count                 = var.create_serverless_neg ? 1 : 0
  provider              = google-beta
  name                  = var.serverless_neg_name
  project               = var.project_id
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = var.cloud_run_service_name
  }
  lifecycle {
    create_before_destroy = true
  }
}