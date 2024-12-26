source "vsphere-iso" "ubuntu2404-base" {
  # vSphere Settings 
  vcenter_server         = var.vsphere_server  
  insecure_connection   = true
  username               = var.vsphere_user
  password               = var.vsphere_password
  datacenter             = var.vsphere_datacenter
  cluster                = var.vsphere_cluster 
  datastore              = var.vsphere_datastore
  folder                 = var.vm_folder
  #convert_to_template    = true
  vm_name                = "${var.vm_template_name}-${formatdate("YYYY-MM-DD", timestamp())}"  # Unique VM name with timestamp
  iso_paths              = ["[${var.vsphere_datastore}]/${var.vm_iso_folder}/${var.vm_iso_file}"]

  # Boot commands for Ubuntu24.04 installation
  boot_command           = [
    "c<wait>",                                # Wait for the system to be ready before sending commands
    "linux /casper/vmlinuz --- autoinstall",  # Ensure the autoinstall option is passed for automated Ubuntu installation
    "<enter><wait>",                          # Wait for the kernel to load
    "initrd /casper/initrd",                  # Load the initrd
    "<enter><wait>",                          # Wait again for the initrd to load
    "boot",                                   # Boot the VM
    "<enter>"
  ] 
  boot_wait              = "3s"               # A bit more time to wait before sending commands, you can increase this if needed

  # CD files for cloud-init (make sure these files exist and are correctly configured)
  cd_files = [
    "./http/meta-data",
    "./http/user-data"
  ]
  cd_label = "cidata"

  # Virtual machine configuration
  guest_os_type         = "ubuntu64Guest"
  vm_version            = var.vm_version
  CPUs                  = var.vm_cpu_num
  RAM                   = var.vm_mem_size
  video_ram             = var.vm_video_ram
  disk_controller_type  = var.vm_disk_controller_type

  # Storage settings
  storage {
    disk_size             = var.vm_disk_size
    disk_thin_provisioned = true  # Thin provisioning saves space but may impact performance depending on workload
  }

  # Network adapter configuration
  network_adapters {
    network               = var.vm_portgroup_name
    network_card          = "vmxnet3"  # vmxnet3 is optimal for performance on vSphere
  }

  # SSH Configuration
  ssh_username            = var.vm_ssh_username
  ssh_password            = var.vm_ssh_password
  ssh_handshake_attempts  = 100
  #ssh_port               = 22
  #ssh_timeout            = "20m"  # 20 minutes is fine for waiting for SSH; adjust if needed

  #shutdown_command        = "sudo shutdown -P now"

}

build {
  sources = ["source.vsphere-iso.ubuntu2404-base"]
 
  # Provisioning Script
  /*
  provisioner "shell" {
    execute_command = "echo '${var.vm_ssh_password}' | {{.Vars}} sudo -S -E bash '{{.Path}}'"  # Ensures sudo access during provisioning
    environment_vars = [
      "BUILD_USERNAME=${var.vm_ssh_username}",
    ]
    scripts = var.shell_scripts  # Ensure your shell scripts are specified correctly
    expect_disconnect = true  # Allows the VM to shut down after provisioning if needed
  }
  */
  provisioner "shell" {
    script       = "./scripts/ubuntu2404-base-post-install.sh"
    pause_before = "30s"
    timeout      = "5m"
  }

}