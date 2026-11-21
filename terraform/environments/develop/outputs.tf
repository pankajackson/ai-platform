output "vm_id" {
  description = "Proxmox VM ID."
  value       = module.ai_vm.vm_id
}

output "vm_name" {
  description = "VM name."
  value       = module.ai_vm.vm_name
}

output "vm_hostname" {
  description = "Guest hostname."
  value       = module.ai_vm.vm_hostname
}

output "vm_ipv4_addresses" {
  description = "Addresses reported by QEMU guest agent."
  value       = module.ai_vm.vm_ipv4_addresses
}

output "ssh_user" {
  description = "SSH user for Ansible."
  value       = module.ai_vm.ssh_user
}

output "ssh_connection" {
  description = "SSH destination template; replace with the VM address."
  value       = "${module.ai_vm.ssh_user}@<vm-ip>"
}

output "ssh_key_pub" {
  sensitive   = true
  description = "SSH destination template; replace with the VM address."
  value       = module.secrets.keys.vm_public_key
}
output "ssh_key_private" {
  sensitive   = true
  description = "SSH destination template; replace with the VM address."
  value       = module.secrets.keys.vm_private_key
}