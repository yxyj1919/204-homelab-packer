source "vsphere-clone" "rocky94-adv" {
  vcenter_server       = var.vsphere_server
  username             = var.vsphere_user
  password             = var.vsphere_password
  insecure_connection  = true

/*
  content_library_destination {
    description       = "Build via Packer from basic template. Version:${var.template_version} ."
    destroy           = "false"
    library           = var.vsphere_content_library
    name              = "${var.vm_name}-latest"
    ovf               = "true"
  }
  convert_to_template = false
*/

  template             = var.vm_template_name
  datacenter           = var.vsphere_datacenter
  cluster              = var.vsphere_cluster

  vm_name              = "${var.vm_new_template_name}-${formatdate("YYYY-MM-DD", timestamp())}"
  folder               = "98-TEMPLATE"
  datastore            = var.vsphere_datastore
  network              = var.vm_portgroup_name
  linked_clone         = false

  customize {
    linux_options {
      host_name           = "custom-rocky9"
      domain              = "local"
    }

    network_interface {
      ipv4_address        = "192.168.100.50"
      ipv4_netmask        = "24"
    }

    dns_server_list      = ["192.168.100.1"]
  }

  #ssh_username         = "vmuser"
  ssh_username         = "root"
  ssh_password         = "Admin123"

}

build {
  sources = ["source.vsphere-clone.rocky94-adv"]

  provisioner "shell" {
    inline = [
      "wget -O /tmp/cleanup.sh https://repo.changw.xyz/cleaup-rocky9.sh",  # URL of the script
      "chmod +x /tmp/cleanup.sh",  # Make the script executable
      "/tmp/cleanup.sh"            # Execute the script
    ]
  }

  provisioner "file" {
    source      = "./scripts/post-install.sh"  # Path to your local script
    destination = "/tmp/post-install.sh"     # Location on the VM
  }

  provisioner "shell" {
    inline = [
      "chmod +x /tmp/post-install.sh",    # Make the script executable
      "/tmp/post-install.sh"              # Run the script
    ]
  }

  post-processor "vsphere-template" {
    folder   = "98-TEMPLATE"
    host     = var.vsphere_server
    username           = var.vsphere_user
    password           = var.vsphere_password
    insecure           = true
    name               = "${var.vm_new_template_name}-${formatdate("YYYY-MM-DD", timestamp())}"
  }
}