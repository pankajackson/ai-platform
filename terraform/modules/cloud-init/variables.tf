variable "hostname" {
  description = "Guest hostname configured by cloud-init."
  type        = string
}

variable "automation_user" {
  description = "Non-root account prepared for Ansible."
  type        = string
}

variable "ssh_public_keys" {
  description = "Public SSH keys authorized for the automation account."
  type        = list(string)
}

variable "timezone" {
  description = "Guest timezone."
  type        = string
  default     = "Etc/UTC"
}

variable "essential_packages" {
  description = "Minimal first-boot packages; application components belong to Ansible."
  type        = list(string)
  default     = ["python3", "sudo", "curl", "qemu-guest-agent"]
}
