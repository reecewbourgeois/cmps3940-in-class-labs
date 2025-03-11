terraform {
  required_providers {
    # https://search.opentofu.org/provider/hashicorp/google/latest
    google = {
      source  = "hashicorp/google"
      version = "6.24.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}
