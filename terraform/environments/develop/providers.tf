provider "proxmox" {
  endpoint = var.proxmox_endpoint
  insecure = var.proxmox_tls_insecure

  # The API token/password is provided through the provider's supported
  # environment variables. SSH agent access is used only for snippet upload.

  ssh {
    agent = true
  }
}
