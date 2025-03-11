# Create a GKE cluster and assign it the private network
resource "google_container_cluster" "primary" {
  name     = var.gke_cluster_name
  location = var.zone

  release_channel {
    channel = "REGULAR"
  }

  network    = google_compute_network.main_network.name
  subnetwork = google_compute_subnetwork.main_subnet.name

  remove_default_node_pool = true
  initial_node_count       = 1

  deletion_protection = false # In a production environment, this should be set to true
}

# TASK: Create a node pool for the GKE cluster so the worker nodes can be created
resource "" {
}

# Service Account for GKE Nodes
resource "google_service_account" "gke_nodes" {
  account_id   = "gke-nodes-sa"
  display_name = "GKE Nodes Service Account"
}

# Assign proper roles
resource "google_project_iam_member" "gke_node_access" {
  project = var.project
  role    = "roles/container.nodeServiceAccount"
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

# Assign proper roles
resource "google_project_iam_member" "storage_reader" {
  project = var.project
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

# Assign proper roles
resource "google_project_iam_member" "artifact_registry_access" {
  project = var.project
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}
