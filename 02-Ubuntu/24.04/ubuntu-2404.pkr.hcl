source "vsphere-iso" "autogenerated_ubuntu2404" {
  # Virtual machine configuration
  CPUs                 = var.vm_cpu_num
  RAM                  = var.vm_mem_size
  boot_command         = [
    "c<wait>",
    "linux /casper/vmlinuz --- autoinstall",
    "<enter><wait>",
    "initrd /casper/initrd",
    "<enter><wait>",
    "boot",
    "<enter>"
  ]
  boot_wait            = "3s"
  cluster              = var.vsphere_cluster
  convert_to_template  = true
  insecure_connection  = true
  datastore            = var.vsphere_datastore
  disk_controller_type = var.vm_disk_controller_type
  folder               = var.vsphere_folder
  guest_os_type        = "ubuntu64Guest"
  iso_paths            = ["[${var.vsphere_datastore}]/${var.iso_folder}/${var.iso_file}"]

  # CD files for cloud-init
  cd_files = [
    "./http/meta-data",
    "./http/user-data"
  ]
  cd_label = "cidata"

  # Network adapter configuration
  network_adapters {
    network      = var.vsphere_portgroup_name
    network_card = "vmxnet3"
  }

  # Authentication settings
  password               = var.vsphere_password
  shutdown_command       = "sudo shutdown -P now"
  ssh_handshake_attempts = 100
  ssh_password           = "ubuntu"
  ssh_port               = 22
  ssh_timeout            = "20m"
  ssh_username           = "ubuntu"

  # Storage settings
  storage {
    disk_size             = var.vm_disk_size
    disk_thin_provisioned = true
  }

  # vSphere server settings
  username       = var.vsphere_user
  vcenter_server = var.vsphere_server
  vm_name        = "${var.vsphere_template_name}-${formatdate("YYYY-MM-DD", timestamp())}"
}

#post-processors {
#post-processor "local-exec" {
#  command = "bash ./scripts/script.sh || { echo 'Script failed'; exit 1; }"
#}
#}

build {
  sources = ["source.vsphere-iso.autogenerated_ubuntu2404"]
}
