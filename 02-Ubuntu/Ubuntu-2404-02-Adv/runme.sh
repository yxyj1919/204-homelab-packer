#!/bin/bash

# 配置 vSphere 环境变量
export GOVC_URL="https://vc.changw.xyz"
export GOVC_USERNAME="administrator@vsphere.local"
export GOVC_PASSWORD="VMware1!"
export GOVC_INSECURE=1

# 获取最新模板
latest_template=$(govc find /Datacenter/vm/98-TEMPLATE  -type m -name 'TEMPLATE-PACKER-Ubuntu2404-01-BASE*'| sort | tail -n 1 )

echo "Searching for the latest template..."
if [[ -z "$latest_template" ]]; then
  echo "No matching template found!"
  exit 1
fi

echo "#################################################"
echo "Using template: $latest_template"
echo "#################################################"

# 运行 Packer
#export PACKER_LOG=1
#packer build -var "vm_template_name=$latest_template" -force .
packer build -var "vm_template_name=$latest_template" -var-file=vsphere.auto.pkrvars.hcl -force .
