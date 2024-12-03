##################################################################################
# vSphere VARIABLES
##################################################################################
vsphere_server = "vc.changw.xyz"
vsphere_user = "administrator@vsphere.local"
vsphere_password = "VMware1!"
vsphere_template_name = "TEMPLATE-PACKER-Ubuntu2404"
vsphere_folder = "98-TEMPLATE"
vsphere_dc_name = "Datacenter"
vsphere_cluster = "11-NUC-Cluster"
vsphere_host = "192.168.100.11"
vsphere_portgroup_name = "Packer-Network"
vsphere_datastore = "11-Datastore-NUC-1-NVME"
#iso_path = ["${vsphere_datastore}/ISO-Packer/ubuntu-24.04-live-server-amd64.iso"]
#iso_path = ["11-Datastore-NUC-1-NVME/ISO-Packer/ubuntu-24.04-live-server-amd64.iso"]
iso_file = "ubuntu-24.04-live-server-amd64.iso"
iso_folder = "ISO-Packer"



cpu_num = 2
mem_size = 4096
disk_size = 40960
vm_disk_controller_type = ["pvscsi"]