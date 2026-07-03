terraform {
  required_version = ">= 1.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
  backend "gcs" {
    bucket = "lz-seed-17021-tfstate"
    prefix = "landing-zone/bootstrap"
  }
}

provider "google" {}

variable "org_id" {
  type    = string
  default = "705240598762"
}

variable "billing_id" {
  type    = string
  default = "01F7AA-9FF1C6-C667F2"
}

resource "google_folder" "workloads" {
  display_name        = "workloads"
  parent              = "organizations/${var.org_id}"
  deletion_protection = false
}

resource "google_project" "app_dev" {
  name                = "lz-app-dev"
  project_id          = "lz-app-dev-27021"
  folder_id           = google_folder.workloads.folder_id
  auto_create_network = false
  deletion_policy     = "DELETE"
  billing_account     = var.billing_id
}

output "folder_name" { value = google_folder.workloads.name }
output "project_id"  { value = google_project.app_dev.project_id }