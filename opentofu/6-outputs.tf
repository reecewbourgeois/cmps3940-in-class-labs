output "postgres_ip_address" {
  value = google_sql_database_instance.postgres_instance.private_ip_address
}

output "gke_cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "artifact_registry_url" {
  value = "${google_artifact_registry_repository.docker_repo.location}-docker.pkg.dev/${google_artifact_registry_repository.docker_repo.project}/${google_artifact_registry_repository.docker_repo.repository_id}"
}
