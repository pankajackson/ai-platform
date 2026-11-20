output "user_data" {
  description = "Rendered cloud-init user-data (public keys only)."
  value       = local.user_data
}
