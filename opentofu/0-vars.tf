variable "project" {
  description = "The project in which the resources will be created"
  default     = "flawless-helper-451201-u9"
}

variable "region" {
  description = "The region in which the resources will be created"
  default     = "us-central1"
}

variable "zone" {
  description = "The zone in which the resources will be created"
  default     = "us-central1-a"
}

variable "main_compute_network" {
  description = "The name of the main compute network"
  default     = "cmps3940-main-network"
}

variable "private_ip_range_name" {
  description = "The name of the private IP range for the VPC network"
  default     = "cmps3940-private-ip-range"
}

variable "main_subnet" {
  description = "The name of the main subnet"
  default     = "cmps-3940-main-subnet"
}

variable "postgres_instance_name" {
  description = "The name of the Cloud SQL database instance"
  default     = "cmps3940-postgres-instance"
}

variable "postgres_db_name" {
  description = "The name of the database in the Cloud SQL instance"
  default     = "cmps3940-database"
}

variable "postgres_db_user" {
  description = "The username for the database user"
  default     = "cmps3940-api"
}

# Note: manually inputting this instead if using an automated solution
# only to reduce GCS cost by not having to enable the Google Secrets Manager API
variable "postgres_db_user_password" {
  description = "value of the password for the database user"
  sensitive   = true
}

variable "docker_repo_id" {
  description = "The ID of the Docker repository"
  default     = "cmps3940-docker-repo"
}

variable "gke_cluster_name" {
  description = "The name of the GKE cluster"
  default     = "cmps3940-gke-cluster"
}

variable "gke_node_pool_name" {
  description = "The name of the GKE node pool"
  default     = "cmps3940-node-pool"
}
