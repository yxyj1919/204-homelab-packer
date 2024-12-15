source "vsphere-iso" "default" {
  CPUs                  = var.vm_cpu_num
  RAM                   = var.vm_mem_size
  RAM_reserve_all       = false
  boot_command          = [
    "<up>",
    "<tab>",
    "<spacebar>",
    " text inst.ks=hd:sr1:/ks.cfg",
    "<enter>"
  ]
  boot_wait             = "10s"
  cluster               = var.vsphere_cluster
  convert_to_template   = true
  datacenter            = var.vsphere_datacenter
  datastore             = var.vsphere_datastore
  disk_controller_type  = var.vm_disk_controller_type
  cd_files              = ["./kickstart/ks.cfg"]
  cd_label              = "OMDRV"
  folder                = var.vm_folder
  guest_os_type         = "rockylinux_64Guest"
  insecure_connection   = true
  iso_paths             = ["[${var.vsphere_datastore}]/${var.iso_folder}/${var.iso_file}"]
  network_adapters      {
    network      = var.vsphere_portgroup_name
    network_card = "vmxnet3"
  }
  password              = var.vsphere_password
  ssh_password          = "Admin123"
  ssh_username          = "root"
  storage {
    disk_size             = var.vm_disk_size
    disk_thin_provisioned = true
  }
  vcenter_server        = var.vsphere_server
  username              = var.vsphere_user
  video_ram             = var.vm_video_ram
  vm_name               = "${var.vsphere_template_name}-${formatdate("YYYY-MM-DD", timestamp())}"
  vm_version            = var.vm_version
}

build {
  sources = ["source.vsphere-iso.default"]

  provisioner "shell" {
    script       = "./scripts/post-install.sh"
    pause_before = "30s"
    timeout      = "2m"
  }
}
