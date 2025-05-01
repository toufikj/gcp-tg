remote_state {
  backend = "gcs"
  config = {
    project  = "terragrunt-demo"
    location = "asia-south1"
    bucket   = "terragunt-demo"
    prefix   = "terraform/state"
  }
}