output "project_ids" {
  value = { for k, p in google_project.this : k => p.project_id }
}
