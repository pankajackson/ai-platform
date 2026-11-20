variable "proxmox_node" {
  description = "Target Proxmox node."
  type        = string
}

variable "vm_id" {
  description = "Unique VM ID selected by the operator."
  type        = number
}

variable "vm_name" {
  description = "VM name and guest hostname."
  type        = string
}

variable "vm_description" {
  description = "VM description."
  type        = string
  default     = "Managed by Terraform"
}

variable "vm_tags" {
  description = "Proxmox VM tags."
  type        = list(string)
  default     = ["terraform", "ai-platform"]
}

variable "cpu_cores" {
  description = "Virtual CPU core count."
  type        = number
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
  description = "Dedicated guest memory in MiB."
  type        = number
}

variable "disk_size_gb" {
  description = "Root disk capacity in GiB."
  type        = number
}

variable "disk_datastore_id" {
  description = "Datastore for the VM disk."
  type        = string
}

variable "image_datastore_id" {
  description = "Datastore for imported Ubuntu image."
  type        = string
}

variable "image_file_name" {
  description = "Ubuntu image filename in the Proxmox datastore."
  type        = string
  default     = "ubuntu-noble-server-cloudimg-amd64.img"
}

variable "image_url" {
  description = "Ubuntu Server LTS cloud image URL. Pin a release URL for controlled upgrades."
  type        = string
  default     = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
}

variable "image_checksum" {
  description = "Optional trusted checksum for the pinned cloud image."
  type        = string
  default     = null
  nullable    = true
}

variable "snippet_datastore_id" {
  description = "Datastore configured to allow snippets."
  type        = string
}

variable "cloud_init_datastore_id" {
  description = "Datastore for the cloud-init drive."
  type        = string
}

variable "cloud_init_user_data" {
  description = "Rendered cloud-init data. Must not contain secrets."
  type        = string
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
  description = "Static IPv4 address, or null to use DHCP."
  type        = string
  default     = null
  nullable    = true
}

variable "ipv4_cidr" {
  description = "Static IPv4 prefix length."
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

variable "start_at_boot" {
  description = "Start the VM with the Proxmox node."
  type        = bool
  default     = true
}

variable "startup_order" {
  description = "Optional Proxmox startup order."
  type        = number
  default     = null
  nullable    = true
}

variable "startup_up_delay" {
  description = "Optional delay in seconds before starting the next VM."
  type        = number
  default     = null
  nullable    = true
}

variable "startup_down_delay" {
  description = "Optional delay in seconds before stopping the next VM."
  type        = number
  default     = null
  nullable    = true
}

variable "automation_user" {
  description = "Guest SSH account used by Ansible."
  type        = string
}

variable "pci_devices" {
  description = "Optional PCI devices. Configure host-side IOMMU/VFIO separately."
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
