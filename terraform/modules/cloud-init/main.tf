locals {
  user_data = templatefile("${path.module}/templates/user-data.yaml.tftpl", {
      hostname            = var.hostname
      automation_user     = var.automation_user
      ssh_authorized_keys = var.ssh_public_keys
      timezone            = var.timezone
      essential_packages  = var.essential_packages
    }
  )
}