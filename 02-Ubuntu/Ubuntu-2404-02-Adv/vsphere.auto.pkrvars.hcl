##################################################################################
# vSphere VARIABLES
##################################################################################
vsphere_server          = "vc.changw.xyz"
vsphere_host            = "192.168.100.11"
vsphere_user            = "administrator@vsphere.local"
vsphere_password        = "VMware1!"
vsphere_datacenter      = "Datacenter"
vsphere_cluster         = "11-NUC-Cluster"
vsphere_datastore       = "11-Datastore-NUC-1-NVME"
vm_template_name        = "TEMPLATE-PACKER-Ubuntu2404-01-BASE-2024-12-22"
vm_new_template_name    = "TEMPLATE-PACKER-Ubuntu2404-02-ADV"
vm_folder               = "98-TEMPLATE"
vsphere_content_library = "HL-MGMT-CL"
vm_ssh_username       = "root"
vm_ssh_password       = "Admin123"
shell_scripts         = ["./scripts/ubuntu2404-adv-post-install.sh"]