variable "ssh_public_key_path" {
  description = "Path to public SSH key"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "timeweb_token" {
  description = "API token from Timeweb Cloud"
  type        = string
}

variable "timeweb_project_id" {
  description = "ID of the Timeweb Cloud project where resources will be created"
  type        = string
}