output "vm_id" {
  description = "Proxmox VM ID."
  value       = proxmox_virtual_environment_vm.this.vm_id
}

output "vm_name" {
  description = "VM name."
  value       = proxmox_virtual_environment_vm.this.name
}

output "vm_hostname" {
  description = "Guest hostname configured by cloud-init."
  value       = var.vm_name
}

output "vm_ipv4_addresses" {
  description = "Addresses reported by QEMU guest agent."
  value       = proxmox_virtual_environment_vm.this.ipv4_addresses
}

output "ssh_user" {
  description = "SSH username for Ansible."
  value       = var.automation_user
}
