variable "shell_scripts" {
  type        = list(string)
  description = "A list of scripts."
  default     = []
}

variable "vm_folder" {
  type    = string
  default = ""
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

variable "vm_latest_template_name" {
  type    = string
  default = ""
}

variable "vm_new_template_name" {
  type    = string
  default = ""
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