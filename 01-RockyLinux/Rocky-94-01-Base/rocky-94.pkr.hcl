source "vsphere-iso" "default" {
  # vSphere Settings
  vcenter_server        = var.vsphere_server
  insecure_connection   = true
  username              = var.vsphere_user
  password              = var.vsphere_password
  datacenter            = var.vsphere_datacenter
  cluster               = var.vsphere_cluster
  datastore             = var.vsphere_datastore
  folder                = var.vm_folder
  convert_to_template   = true
  vm_name               = "${var.vm_template_name}-${formatdate("YYYY-MM-DD", timestamp())}"
  iso_paths             = ["[${var.vsphere_datastore}]/${var.vm_iso_folder}/${var.vm_iso_file}"]

  # Boot commands for Rocky Linux 9 installation
  boot_wait             = "10s"
  ##############################
  /*
  boot_command          = [
    "<esc><wait>",
    "linux text inst.ks=hd:sr1:/ks.cfg<enter>"
  ]
  */
  ##############################
  boot_command          = [
    "<up>",
    "<tab>",
    "<spacebar>",
    " text inst.ks=hd:sr1:/ks.cfg",
    "<enter>"
  ]
  # CD files for cloud-init (make sure these files exist and are correctly configured)

  cd_files              = ["./kickstart/ks.cfg"]
  cd_label              = "OMDRV"

# Virtual machine configuration
  guest_os_type         = "rockylinux_64Guest"
  vm_version            = var.vm_version
  CPUs                  = var.vm_cpu_num
  RAM                   = var.vm_mem_size
  RAM_reserve_all       = false
  video_ram             = var.vm_video_ram
  disk_controller_type  = var.vm_disk_controller_type

  # Storage definition
  storage {
    disk_size             = var.vm_disk_size
    disk_thin_provisioned = true
  }

  # Network adapters
  network_adapters {
    network      = var.vm_portgroup_name
    network_card = var.vm_vnic
  }

  # SSH Configuration
  ssh_username          = var.vm_ssh_username
  ssh_password          = var.vm_ssh_password
}

build {
  sources = ["source.vsphere-iso.default"]

  # Provisioning Script
  provisioner "shell" {
    script       = "./scripts/post-install.sh"
    pause_before = "30s"
    timeout      = "5m"
  }
}