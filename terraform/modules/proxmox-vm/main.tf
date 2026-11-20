resource "proxmox_virtual_environment_file" "cloud_init" {
  content_type = "snippets"
  datastore_id = var.snippet_datastore_id
  node_name    = var.proxmox_node

  source_raw {
    data      = var.cloud_init_user_data
    file_name = "${var.vm_name}-user-data.yaml"
  }
}

resource "proxmox_download_file" "ubuntu_cloud_image" {
  content_type = "iso"
  datastore_id = var.image_datastore_id
  node_name    = var.proxmox_node
  file_name    = var.image_file_name
  url          = var.image_url
  checksum     = var.image_checksum
  overwrite    = false
}

resource "proxmox_virtual_environment_vm" "this" {
  name        = var.vm_name
  description = var.vm_description
  node_name   = var.proxmox_node
  vm_id       = var.vm_id
  tags        = var.vm_tags
  on_boot     = var.start_at_boot
  machine     = var.machine_type

  agent {
    enabled = true
    wait_for_ip {
      ipv4 = true
    }
  }

  cpu {
    cores = var.cpu_cores
    type  = var.cpu_type
  }

  memory {
    dedicated = var.memory_mb
  }

  disk {
    datastore_id = var.disk_datastore_id
    file_id      = proxmox_download_file.ubuntu_cloud_image.id
    interface    = "scsi0"
    size         = var.disk_size_gb
    iothread     = true
    discard      = "on"
  }

  network_device {
    bridge   = var.network_bridge
    vlan_id  = var.vlan_tag
    firewall = true
    model    = "virtio"
  }

  initialization {
    datastore_id      = var.cloud_init_datastore_id
    user_data_file_id = proxmox_virtual_environment_file.cloud_init.id

    dns {
      servers = var.dns_servers
    }

    ip_config {
      ipv4 {
        address = var.ipv4_address == null ? "dhcp" : "${var.ipv4_address}/${var.ipv4_cidr}"
        gateway = var.ipv4_address == null ? null : var.ipv4_gateway
      }
    }
  }

  dynamic "hostpci" {
    for_each = var.pci_devices
    content {
      device  = hostpci.value.device
      id      = try(hostpci.value.id, null)
      mapping = try(hostpci.value.mapping, null)
      pcie    = try(hostpci.value.pcie, true)
      rombar  = try(hostpci.value.rombar, true)
      xvga    = try(hostpci.value.xvga, false)
    }
  }

  dynamic "startup" {
    for_each = var.startup_order == null ? [] : [var.startup_order]
    content {
      order      = startup.value
      up_delay   = var.startup_up_delay
      down_delay = var.startup_down_delay
    }
  }

  lifecycle {
    precondition {
      condition     = var.ipv4_address == null || (var.ipv4_gateway != null && var.ipv4_cidr != null)
      error_message = "Static IPv4 requires ipv4_cidr and ipv4_gateway."
    }

    precondition {
      condition = alltrue([
        for device in var.pci_devices : (try(device.id, null) != null) != (try(device.mapping, null) != null)
      ])
      error_message = "Each PCI device must set exactly one of id or mapping."
    }
  }
}
