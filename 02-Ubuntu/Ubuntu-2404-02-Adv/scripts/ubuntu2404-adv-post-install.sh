#!/usr/bin/bash

# Prepares an Ubuntu Server guest operating system.
echo "######################################"
echo "Ubuntu2404-ADV-Post-Install"
echo "######################################"

### Update Packages. ###
echo "######################################"
echo "Update Packages."
echo "######################################"
sudo apt update 
sudo upgrade -y
sudo apt install open-vm-tools open-vm-tools-desktop -y



### Install docker. ###
echo "######################################"
echo "Install Docker"
echo "######################################"
apt update -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt update -y
apt-cache policy docker-ce
apt install docker-ce -y
#groupadd docker
usermod -aG docker vmuser

# Install Tools#
echo "######################################"
echo "Install Tools"
echo "######################################"
apt install gparted -y 

#sed -i 's/^disable_vmware_customization/#disable_vmware_customization/g' /etc/cloud/cloud.cfg
sed -i '/^disable_vmware_customization/s/^/#/'  /etc/cloud/cloud.cfg
tee /etc/cloud/cloud.cfg.d/80_disable_network.cfg > /dev/null << EOF
network:
  config: disabled
EOF


echo "######################################"
echo "Rocky9-ADV-Post-Install -- Complete"
echo "######################################"
echo '> Packer Template Build -- Complete'