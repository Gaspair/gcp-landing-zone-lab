terraform {
  required_providers {
    google = { source = "hashicorp/google", version = ">= 5.0" }
    random = { source = "hashicorp/random" }
  }
}

# A unique suffix per project — solves the "IDs reserved for 30 days" problem
resource "random_id" "suffix" {
  for_each    = var.projects
  byte_length = 3
}

resource "google_project" "this" {
  for_each            = var.projects
  name                = each.key
  project_id          = "${each.key}-${random_id.suffix[each.key].hex}"
  folder_id           = var.folder_id
  billing_account     = var.billing_id
  auto_create_network = false
  deletion_policy     = "DELETE"
  labels = {
    team = each.value.team
    env  = each.value.environment
  }
}