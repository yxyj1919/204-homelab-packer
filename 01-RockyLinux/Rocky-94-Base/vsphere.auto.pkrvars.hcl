##################################################################################
# vSphere VARIABLES
##################################################################################
vsphere_server        = "vc.changw.xyz"
vsphere_host          = "192.168.100.11"
vsphere_user          = "administrator@vsphere.local"
vsphere_password      = "VMware1!"
vsphere_datacenter     = "Datacenter"
vsphere_cluster        = "11-NUC-Cluster"
vsphere_datastore      = "11-Datastore-NUC-1-NVME"

#vm_cpu_num            = 2
#vm_disk_size          = 40960
#vm_mem_size           = 2048
vm_video_ram          = 16384
#vm_version            = 21
vm_folder              = "98-TEMPLATE"
vm_portgroup_name      = "Packer-Network"
vm_template_name       = "TEMPLATE-PACKER-Rocky94-BASE-HL"
vm_iso_file = "Rocky-9.4-x86_64-dvd.iso"
vm_iso_folder = "ISO-Packer"