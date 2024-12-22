source "vsphere-clone" "rocky94-adv" {
  vcenter_server       = var.vsphere_server
  username             = var.vsphere_user
  password             = var.vsphere_password
  insecure_connection  = true

  template             = var.vm_latest_template_name
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

  ssh_username         = "vmuser"
  ssh_password         = "Admin123"

}

build {
  sources = ["source.vsphere-clone.rocky94-adv"]

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