#!/usr/bin/bash

# Prepares a Rocky9 Server guest operating system.
echo "######################################"
echo "Rocky9-ADV-Post-Install"
echo "######################################"

<<COMMENT
# Modify DNF Source. #
echo "######################################"
echo "Modify DNF Source."
echo "######################################"  
sed -i 's/^enabled=1/enabled=0/' /etc/yum.repos.d/*.repo
wget -O /etc/yum.repos.d/rocky-local.repo  https://repo.changw.xyz/rocky-local.repo
wget -O /etc/yum.repos.d/epel-local.repo  https://repo.changw.xyz/epel-local.repo
wget -O /etc/yum.repos.d/epel-local.repo  https://repo.changw.xyz/docker-local.repo
yum clean all
yum makecache
COMMENT

# Update Packages. #
echo "######################################"
echo "Update Packages."
echo "######################################"
dnf makecache
dnf update -y
#sleep 10

# Install docker. #
echo "######################################"
echo "Install Docker"
echo "######################################"
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
wget -O /etc/yum.repos.d/docker-local.repo  https://repo.changw.xyz/docker-local.repo
dnf makecache
dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
systemctl enable docker
systemctl start docker
#groupadd docker
usermod -aG docker vmuser

# Install Tools#
echo "######################################"
echo "Install Tools"
echo "######################################"
dnf install gparted -y 

#nmcli connection modify ens192 ipv4.method auto ipv4.addresses "" ipv4.gateway "" ipv4.dns "" ipv6.method auto
#nmcli connection up ens192

echo "######################################"
echo "Rocky9-ADV-Post-Install -- Complete"
echo "######################################"
echo '> Packer Template Build -- Complete'


