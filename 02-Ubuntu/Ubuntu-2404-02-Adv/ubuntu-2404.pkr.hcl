source "vsphere-clone" "ubuntu2404-adv" {
  # vSphere Settings 
  vcenter_server       = var.vsphere_server
  username             = var.vsphere_user
  password             = var.vsphere_password
  insecure_connection  = true

content_library_destination {
    destroy = "false"
    library = var.vsphere_content_library
    name    = "${var.vm_new_template_name}-${formatdate("YYYY-MM-DD", timestamp())}"
    ovf     = "true"
}
  convert_to_template = "false"

  template             = var.vm_template_name
  datacenter           = var.vsphere_datacenter
  cluster              = var.vsphere_cluster

  vm_name              = "${var.vm_new_template_name}-${formatdate("YYYY-MM-DD", timestamp())}"
  folder               = var.vm_folder
  datastore            = var.vsphere_datastore
  network              = var.vm_portgroup_name
  linked_clone         = false

  customize {
    linux_options {
      host_name           = "ubuntu2404-adv"
      domain              = "local"
    }
    network_interface {
      ipv4_address        = ""
    }
  }

  #ssh_username         = "Admin123"
  ssh_username         = var.vm_ssh_username
  ssh_password         = var.vm_ssh_password
}

build {
  sources = ["source.vsphere-clone.ubuntu2404-adv"]

  provisioner "file" {
    #source      = "./scripts/ubuntu2404-adv-post-install.sh"  # Path to your local script
    sources      =  var.shell_scripts
    destination = "/tmp/post-install.sh"     # Location on the VM
  }

  provisioner "shell" {
    inline = [
      "chmod +x /tmp/post-install.sh",    # Make the script executable
      "/tmp/post-install.sh"              # Run the script
    ]
  }

  provisioner "shell" {
    inline = [
      "while ! ping -c 1 192.168.100.1; do sleep 5; done",
      "echo Network is ready."
    ]
  }

  provisioner "shell" {
    inline = [
      "wget -O /tmp/cleanup.sh https://repo.changw.xyz/ubuntu-2404-cleanup.sh",
      "chmod +x /tmp/cleanup.sh",  # Make the script executable
      "/tmp/cleanup.sh"            # Execute the script
    ]
  }

  post-processor "vsphere-template" {
    folder             = var.vm_folder
    host               = var.vsphere_server
    username           = var.vsphere_user
    password           = var.vsphere_password
    insecure           = true
    name               = "${var.vm_new_template_name}-${formatdate("YYYY-MM-DD", timestamp())}"
  }
}