variable "shell_scripts" {
  type        = list(string)
  description = "A list of scripts."
  default     = []
}

variable "vm_cpu_num" {
  type    = string
  default = "2"
}

variable "vm_disk_controller_type" {
  type        = list(string)
  description = "The virtual disk controller types in sequence. (e.g. 'pvscsi')"
  default     = ["pvscsi"]
}

variable "vm_disk_size" {
  type    = string
  default = "40960"
}

variable "vm_folder" {
  type    = string
  default = ""
}

variable "vm_iso_file" {
  type    = string
  default = ""
}

variable "vm_iso_folder" {
  type        = string
  description = "The path on the source vSphere datastore for ISO images."
  default     = ""
}

variable "vm_mem_size" {
  type    = string
  default = "4096"
}

variable "vm_portgroup_name" {
  type    = string
  default = ""
}

variable "vm_ssh_password" {
  type      = string
  default   = "Admin123"
  sensitive = true
}

variable "vm_ssh_username" {
  type      = string
  default   = "root"
  sensitive = true
}

variable "vm_template_name" {
  type    = string
  default = ""
}

variable "vm_version" {
  type    = string
  default = "21"
}

variable "vm_video_ram" {
  type    = string
  default = "4096"
}

variable "vm_vnic" {
  type    = string
  default = "vmxnet3"
}

variable "vsphere_cluster" {
  type    = string
  default = ""
}

variable "vsphere_datacenter" {
  type    = string
  default = ""
}

variable "vsphere_datastore" {
  type    = string
  default = ""
}

variable "vsphere_password" {
  type      = string
  sensitive = true
}

variable "vsphere_server" {
  type    = string
  default = ""
}

variable "vsphere_user" {
  type    = string
  default = ""
}