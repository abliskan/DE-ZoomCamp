variable "credentials" {
  description = "My credentials"
  default = file("<credentials>")
}

variable "project" {
  description = "Project"
  default = "<PROJECT_ID>"
}

variable "region" {
  description = "Region"
  default = "us-central1"
}

variable "zone" {
  description = "Zone"
  default = "us-central1-c"
}

variable "location" {
  description = "Project Location"
  default = "US"
}

variable "bg_dataset_name" {
  description = "My Biquery Dataset Name"
  default = "demo_dataset"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default = "<PROJECT_ID>-terra-form"
}

variable "gcs_bucket_class" {
  description = "Bucket Storage Class"
  default = "STANDARD"
}