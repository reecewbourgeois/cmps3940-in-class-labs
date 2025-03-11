# TASK: Go through and add default values

variable "project" {
  description = "The project in which the resources will be created"
}

variable "region" {
  description = "The region in which the resources will be created"
}

variable "zone" {
  description = "The zone in which the resources will be created"
}

variable "main_compute_network" {
  description = "The name of the main compute network"
}

variable "private_ip_range_name" {
  description = "The name of the private IP range for the VPC network"
}

variable "main_subnet" {
  description = "The name of the main subnet"
}

variable "postgres_instance_name" {
  description = "The name of the Cloud SQL database instance"
}

variable "postgres_db_name" {
  description = "The name of the database in the Cloud SQL instance"
}

variable "postgres_db_user" {
  description = "The username for the database user"
}

variable "docker_repo_id" {
  description = "The ID of the Docker repository"
}

variable "gke_cluster_name" {
  description = "The name of the GKE cluster"
}

variable "gke_node_pool_name" {
  description = "The name of the GKE node pool"
}
