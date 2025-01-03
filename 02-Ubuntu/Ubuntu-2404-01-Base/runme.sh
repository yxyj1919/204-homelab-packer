#!/bin/bash

# 配置 vSphere 环境变量
export GOVC_URL="https://vc.changw.xyz"
export GOVC_USERNAME="administrator@vsphere.local"
export GOVC_PASSWORD="VMware1!"
export GOVC_INSECURE=1

# 运行 Packer
#export PACKER_LOG=1
#packer build -var "vm_template_name=$latest_template" -force .
echo "###################################"
echo "Building the Virtual Machine"
echo "###################################"
packer build -var-file=vsphere.auto.pkrvars.hcl -force .

# 转化成模板
echo "###################################"
echo "Making the template" 
echo "###################################"
vm_name=$(govc find /Datacenter/vm/98-TEMPLATE  -type m -name 'TEMPLATE-PACKER-Ubuntu2404-01-BASE*' | sort | tail -n 1)
echo "Find the VM: "$vm_name
govc device.remove -vm $vm_name cdrom-3001
govc vm.markastemplate $vm_name
