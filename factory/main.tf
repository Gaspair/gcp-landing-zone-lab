terraform {
  required_version = ">= 1.5"
  required_providers {
    google = { source = "hashicorp/google", version = ">= 5.0" }
    random = { source = "hashicorp/random" }
  }
  backend "gcs" {
    bucket = "lz-seed-17021-tfstate"
    prefix = "landing-zone/factory"
  }
}

provider "google" {}

variable "folder_id"  { default = "563159966652" }          # workloads folder from Day 1
variable "billing_id" { default = "01F7AA-9FF1C6-C667F2" }

# THE DATA FILE: onboarding a team = adding a few lines here
locals {
  projects = {
    payments-dev = { team = "payments", environment = "dev" }
    fraud-dev    = { team = "fraud",    environment = "dev" }
    risk-dev     = { team = "risk",     environment = "dev" }
  }
}

module "project_factory" {
  source     = "./modules/project-factory"
  projects   = local.projects
  folder_id  = var.folder_id
  billing_id = var.billing_id
}

output "created_projects" {
  value = module.project_factory.project_ids
}
##
