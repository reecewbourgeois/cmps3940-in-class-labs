# Create a Docker repository
resource "google_artifact_registry_repository" "docker_repo" {
  provider      = google
  project       = var.project
  location      = var.region
  repository_id = var.docker_repo_id
  format        = "DOCKER"
  description   = "Docker repository for GKE workloads"
}
