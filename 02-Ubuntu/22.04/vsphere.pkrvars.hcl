##################################################################################
# VARIABLES
##################################################################################
# Credentials
vcenter_username                = "administrator@vsphere.local"
vcenter_password                = "VMware1!"
# vSphere Objects
vcenter_insecure_connection     = true
vcenter_server                  = "vc.changw.xyz"
vcenter_datacenter              = "Datacenter"
#vcenter_host                    = "192.168.100.11"
vcenter_cluster                 = "11-NUC-Cluster"
vcenter_datastore               = "11-Datastore-NUC-1-NVME"
vcenter_network                 = "Packer-Network"
vcenter_folder                  = "98-TEMPLATE"

# ISO Objects
iso_path                        = "[11-Datastore-NUC-1-NVME] /ISO-Packer" 