module "secrets" {
  source = "../../modules/vm-secrets"
}

module "cloud_init" {
  source          = "../../modules/cloud-init"
  hostname        = var.vm_name
  automation_user = var.automation_user
  ssh_public_keys = concat(
    var.ssh_public_keys,
    [module.secrets.keys.vm_public_key]
  )
  timezone           = var.timezone
  essential_packages = var.bootstrap_packages
}

module "ai_vm" {
  source                  = "../../modules/proxmox-vm"
  proxmox_node            = var.proxmox_node
  vm_id                   = var.vm_id
  vm_name                 = var.vm_name
  vm_description          = var.vm_description
  vm_tags                 = var.vm_tags
  cpu_cores               = var.cpu_cores
  cpu_type                = var.cpu_type
  machine_type            = var.machine_type
  memory_mb               = var.memory_mb
  disk_size_gb            = var.disk_size_gb
  disk_datastore_id       = var.disk_datastore_id
  image_datastore_id      = var.image_datastore_id
  image_file_name         = var.image_file_name
  image_url               = var.image_url
  image_checksum          = var.image_checksum
  snippet_datastore_id    = var.snippet_datastore_id
  cloud_init_datastore_id = var.cloud_init_datastore_id
  cloud_init_user_data    = module.cloud_init.user_data
  network_bridge          = var.network_bridge
  vlan_tag                = var.vlan_tag
  ipv4_address            = var.ipv4_address
  ipv4_cidr               = var.ipv4_cidr
  ipv4_gateway            = var.ipv4_gateway
  dns_servers             = var.dns_servers
  start_at_boot           = var.start_at_boot
  startup_order           = var.startup_order
  startup_up_delay        = var.startup_up_delay
  startup_down_delay      = var.startup_down_delay
  automation_user         = var.automation_user
  pci_devices             = var.pci_devices
}
