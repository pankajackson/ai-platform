variable "proxmox_endpoint" {
  description = "HTTPS Proxmox API endpoint."
  type        = string
  validation {
    condition     = can(regex("^https://", var.proxmox_endpoint))
    error_message = "proxmox_endpoint must use HTTPS."
  }
}

variable "proxmox_tls_insecure" {
  description = "Allow an untrusted certificate; install a trusted certificate when possible."
  type        = bool
  default     = false
}

variable "proxmox_username" {
  description = "Proxmox API username"
  type        = string
}

variable "proxmox_password" {
  description = "Proxmox API password"
  type        = string
  sensitive   = true
  nullable    = false
}

variable "proxmox_node" {
  description = "Target Proxmox node."
  type        = string
}

variable "vm_id" {
  description = "Unused unique Proxmox VM ID selected by the operator."
  type        = number
  validation {
    condition     = var.vm_id >= 100
    error_message = "vm_id must be an available Proxmox VM ID of at least 100."
  }
}

variable "vm_name" {
  description = "VM name and cloud-init hostname."
  type        = string
  default     = "ai-platform"
}

variable "vm_description" {
  description = "VM description."
  type        = string
  default     = "Self-hosted AI platform"
}

variable "vm_tags" {
  description = "Proxmox VM tags."
  type        = list(string)
  default     = ["terraform", "ai-platform", "homelab"]
}

variable "cpu_cores" {
  description = "Virtual CPU core count."
  type        = number
  default     = 8
}

variable "cpu_type" {
  description = "Proxmox CPU type."
  type        = string
  default     = "host"
}

variable "machine_type" {
  description = "QEMU machine type; q35 supports PCIe passthrough."
  type        = string
  default     = "q35"
}

variable "memory_mb" {
  description = "Guest RAM in MiB."
  type        = number
  default     = 16384
}

variable "disk_size_gb" {
  description = "Root disk size in GiB."
  type        = number
  default     = 100
}

variable "disk_datastore_id" {
  description = "Datastore for VM disk."
  type        = string
}

variable "image_datastore_id" {
  description = "Datastore allowing imported cloud images."
  type        = string
}

variable "image_file_name" {
  description = "Image filename on Proxmox storage."
  type        = string
  default     = "ubuntu-noble-server-cloudimg-amd64.img"
}

variable "image_url" {
  description = "Ubuntu Server LTS cloud image URL."
  type        = string
  default     = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
}

variable "image_checksum" {
  description = "Optional trusted checksum for a pinned image release."
  type        = string
  default     = null
  nullable    = true
}

variable "snippet_datastore_id" {
  description = "Datastore configured for snippets."
  type        = string
}

variable "cloud_init_datastore_id" {
  description = "Datastore used for the cloud-init drive."
  type        = string
  default     = "local-lvm"
}

variable "network_bridge" {
  description = "Proxmox network bridge."
  type        = string
}

variable "vlan_tag" {
  description = "Optional VLAN tag."
  type        = number
  default     = null
  nullable    = true
}

variable "ipv4_address" {
  description = "Static IPv4 address, or null for DHCP."
  type        = string
  default     = null
  nullable    = true
}

variable "ipv4_cidr" {
  description = "Static prefix length."
  type        = number
  default     = null
  nullable    = true
}

variable "ipv4_gateway" {
  description = "Static IPv4 gateway."
  type        = string
  default     = null
  nullable    = true
}

variable "dns_servers" {
  description = "DNS resolver addresses."
  type        = list(string)
  default     = []
}

variable "automation_user" {
  description = "Non-root SSH account used by Ansible."
  type        = string
  default     = "automation"
}

variable "ssh_public_keys" {
  description = "SSH public keys for the automation account."
  type        = list(string)
  validation {
    condition     = length(var.ssh_public_keys) > 0
    error_message = "At least one SSH public key is required."
  }
}

variable "timezone" {
  description = "Guest timezone."
  type        = string
  default     = "Etc/UTC"
}

variable "bootstrap_packages" {
  description = "Minimal first-boot packages only."
  type        = list(string)
  default     = ["python3", "sudo", "curl", "qemu-guest-agent"]
}

variable "start_at_boot" {
  description = "Start VM automatically with Proxmox."
  type        = bool
  default     = true
}

variable "startup_order" {
  description = "Optional startup order."
  type        = number
  default     = null
  nullable    = true
}

variable "startup_up_delay" {
  description = "Optional startup delay in seconds."
  type        = number
  default     = null
  nullable    = true
}

variable "startup_down_delay" {
  description = "Optional shutdown delay in seconds."
  type        = number
  default     = null
  nullable    = true
}

variable "pci_devices" {
  description = "Optional PCI devices. Host passthrough setup remains external."
  type = list(object({
    device  = string
    id      = optional(string)
    mapping = optional(string)
    pcie    = optional(bool, true)
    rombar  = optional(bool, true)
    xvga    = optional(bool, false)
  }))
  default = []
}
