# Create database instance and assign resources
resource "google_sql_database_instance" "postgres_instance" {
  name                = var.postgres_instance_name
  region              = var.region
  database_version    = "POSTGRES_16"
  deletion_protection = false # In a production environment, this should be set to true

  settings {
    tier    = "db-f1-micro"
    edition = "ENTERPRISE"

    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = google_compute_network.main_network.self_link
      enable_private_path_for_google_cloud_services = true
    }
  }

  # Make sure the database instance is created after the private service connection
  depends_on = [google_service_networking_connection.private_service_connection]
}

# Create database
resource "google_sql_database" "database" {
  name     = var.postgres_db_name
  instance = google_sql_database_instance.postgres_instance.name
}

# Create database user
resource "google_sql_user" "db_user" {
  name     = var.postgres_db_user
  instance = google_sql_database_instance.postgres_instance.name
  password = var.postgres_db_user_password
}
