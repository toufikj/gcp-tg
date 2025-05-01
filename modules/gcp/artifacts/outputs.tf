output "artifact_id" {
  value       = module.artifact_registry.artifact_id
  description = "The ID of the Cloud Run artifact"
}
output create_time {
  value       = module.artifact_registry.create_time
  description = "The time the artifact was created"
}
