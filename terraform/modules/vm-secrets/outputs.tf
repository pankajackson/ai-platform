output "keys" {
  description = "Sensitive VM credentials and generated secrets including VM SSH private key, VM password."

  sensitive = true

  value = {
    vm_private_key = tls_private_key.vm_key.private_key_pem
    vm_public_key  = tls_private_key.vm_key.public_key_openssh
    vm_password    = random_password.vm_password.result
  }
}