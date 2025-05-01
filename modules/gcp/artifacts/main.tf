module "artifact_registry" {
  source  = "GoogleCloudPlatform/artifact-registry/google"
  version = "~> 0.3"

  # Required variables
  project_id    = var.project_id
  location      = var.region
  format        = var.format
  repository_id = var.repository_id
}