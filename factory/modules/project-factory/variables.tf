variable "projects" {
  type = map(object({
    team        = string
    environment = string
  }))
}
variable "folder_id"  { type = string }
variable "billing_id" { type = string }