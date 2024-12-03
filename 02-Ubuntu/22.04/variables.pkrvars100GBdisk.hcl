##################################################################################
# VARIABLES
##################################################################################

# HTTP Settings

http_directory = "http"

# Virtual Machine Settings

vm_name                     = "Ubuntu-2204-Template-100GB-Thin"
vm_guest_os_type            = "ubuntu64Guest"
vm_version                  = 14
vm_firmware                 = "bios"
vm_cdrom_type               = "sata"
vm_cpu_sockets              = 1
vm_cpu_cores                = 1
vm_mem_size                 = 1024
vm_disk_size                = 102400
thin_provision              = true
disk_eagerly_scrub          = false
vm_disk_controller_type     = ["pvscsi"]
vm_network_card             = "vmxnet3"
vm_boot_wait                = "5s"
ssh_username                = "ubuntu"
ssh_password                = "ubuntu"

# ISO Objects

iso_file                    = "ubuntu-22.04.5-live-server-amd64.iso"
#iso_checksum                = "9bc6028870aef3f74f4e16b900008179e78b130e6b0b9a140635434a46aa98b0"
#iso_checksum_type           = "sha256"
#iso_url                     = "https://releases.ubuntu.com/jammy/ubuntu-22.04.5-live-server-amd64.iso" 

# Scripts

shell_scripts               = ["./scripts/setup_ubuntu2204_withDocker.sh"]