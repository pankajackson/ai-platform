# Proxmox VM module

Creates an Ubuntu Server LTS VM, downloads its cloud image, uploads a cloud-init snippet, and optionally attaches PCI devices. The Proxmox node needs `import` content enabled on the image datastore and `snippets` enabled on the user-data datastore. Uploading the snippet requires SSH access configured in the provider.

Host IOMMU/VFIO setup, PCI isolation, device binding, and GPU reset compatibility remain Proxmox operator responsibilities. No credentials are passed through cloud-init.
