##################################################################################
# vSphere VARIABLES
##################################################################################
iso_url               = "[11-Datastore-NUC-1-NVME] ISO-Packer/Rocky-9.4-x86_64-dvd.iso"
#magic_reference_date  = "2024-11-26"
vm_cpu_num            = 2
vm_disk_size          = 40960
vm_folder             = "98-TEMPLATE"
vm_mem_size           = 2048
vsphere_template_name  = "TEMPLATE-PACKER-Rocky94-Base"
vm_version            = 21
vm_video_ram          = 16384
vsphere_datacenter    = "Datacenter"
vsphere_cluster       = "11-NUC-Cluster"
vsphere_datastore     = "11-Datastore-NUC-1-NVME"
vsphere_portgroup_name  = "Packer-Network"
vsphere_password      = "VMware1!"
vsphere_server        = "vc.changw.xyz"
vsphere_user          = "administrator@vsphere.local"
vsphere_host          = "192.168.100.11"
iso_file = "Rocky-9.4-x86_64-dvd.iso"
iso_folder = "ISO-Packer"