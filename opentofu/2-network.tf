# VPC Network
resource "google_compute_network" "main_network" {
  name                    = var.main_compute_network
  auto_create_subnetworks = false
}

# Reserved IP Range for Private Services Access
resource "google_compute_global_address" "private_ip_range" {
  name          = var.private_ip_range_name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.main_network.id

  lifecycle {
    prevent_destroy = false
  }
}

# Subnet for Private IP
resource "google_compute_subnetwork" "main_subnet" {
  name                     = var.main_subnet
  ip_cidr_range            = "10.10.0.0/16" # Allow for the last two octets to be used for private IP addresses
  region                   = var.region
  network                  = google_compute_network.main_network.id
  private_ip_google_access = true
}

# Private Service Connection for Cloud SQL
resource "google_service_networking_connection" "private_service_connection" {
  network                 = google_compute_network.main_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_range.name]
  deletion_policy         = "ABANDON" # This is to prevent an error when destroying the infrastructure. Note that the private IP range will not be deleted.
}

