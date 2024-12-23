##################################################################################
# vSphere VARIABLES
##################################################################################
vsphere_server        = "vc.changw.xyz"
vsphere_host          = "192.168.100.11"
vsphere_user          = "administrator@vsphere.local"
vsphere_password      = "VMware1!"
vsphere_dc_name       = "Datacenter"
vsphere_cluster       = "11-NUC-Cluster"
vsphere_datastore     = "11-Datastore-NUC-1-NVME"

vm_cpu_num            = 2
vm_mem_size           = 4096
vm_disk_size          = 40960
vm_video_ram          = 16384

#vm_version           = 21
vm_folder             = "98-TEMPLATE"
vm_portgroup_name     = "Packer-Network"
vm_template_name      = "TEMPLATE-PACKER-Ubuntu2404-01-BASE"
vm_iso_file           = "ubuntu-24.04-live-server-amd64.iso"
vm_iso_folder         = "ISO-Packer"

shell_scripts = ["./scripts/ubuntu2404-base-post-install.sh"]

#iso_path = ["${vsphere_datastore}/ISO-Packer/ubuntu-24.04-live-server-amd64.iso"]
#iso_path = ["11-Datastore-NUC-1-NVME/ISO-Packer/ubuntu-24.04-live-server-amd64.iso"]
#vm_disk_controller_type = ["pvscsi"]
