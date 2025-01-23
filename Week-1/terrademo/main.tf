terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  # Use reference variable from project, region & zone
  credentials = file(var.credentials) # call the credentials using file() function
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_storage_bucket" "demo-bucket" {
  # Use reference variable from gcs_bucket_name & location
  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

resource "google_bigquery_dataset" "demo_dataset" {
  # Use reference variable from bg_dataset_name & location
  dataset_id = var.bg_dataset_name
  location = var.location
}