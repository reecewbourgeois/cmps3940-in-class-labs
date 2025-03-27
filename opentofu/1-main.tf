terraform {
  required_providers {
    # https://search.opentofu.org/provider/hashicorp/google/latest
    google = {
      source  = "hashicorp/google"
      version = "6.24.0"
    }
  }

  # Manually create Cloud Storage bucket for simplicity
  backend "gcs" {
    bucket = "your_bucket_here"
    prefix = "some_prefix_here"
  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}
