#!/usr/bin/bash

# Prepares a Rocky9 Server guest operating system.#
echo "######################################"
echo "Rocky9-Base-Post-Install"
echo "######################################"

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

# Update Packages. #
echo "######################################"
echo "Update Packages."
echo "######################################"
yum update -y
yum clean all

# Create a cleanup script. #
echo "######################################"
echo "Create a cleanup script."
echo "######################################"
echo '> Creating cleanup script ...'
sudo cat << EOF > /tmp/cleanup.sh
#!/bin/bash
echo '> Creating cleanup script ...'

# 1. Cleans all audit logs.
echo '> 1. Cleaning all audit logs ...'
if [ -f /var/log/audit/audit.log ]; then
  cat /dev/null > /var/log/audit/audit.log
fi
if [ -f /var/log/wtmp ]; then
  cat /dev/null > /var/log/wtmp
fi
if [ -f /var/log/lastlog ]; then
  cat /dev/null > /var/log/lastlog
fi

# 2. Cleans persistent udev rules.
echo '> 2. Cleaning persistent udev rules ...'
if [ -f /etc/udev/rules.d/70-persistent-net.rules ]; then
  rm /etc/udev/rules.d/70-persistent-net.rules
fi

# 3. Cleans /tmp directories.
echo '> 3. Cleaning /tmp directories ...'
rm -rf /tmp/*
rm -rf /var/tmp/*

# 4. Cleans SSH keys.
echo '> 4. Cleaning SSH keys ...'
rm -f /etc/ssh/ssh_host_*

# 5. Sets hostname to localhost.
echo '> 5. Setting hostname to localhost ...'
# Uncomment this part to set hostname to localhost if needed.
# cat /dev/null > /etc/hostname
# hostnamectl set-hostname localhost

# 6. Cleans dnf cache and removes unnecessary packages.
echo '> 6. Cleaning dnf ...'
dnf clean all
dnf autoremove -y

# 7. Cleans the machine-id.
echo '> 7. Cleaning the machine-id ...'
truncate -s 0 /etc/machine-id
rm /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id

# 8. Cleans shell history.
echo '> 8. Cleaning shell history ...'
unset HISTFILE
history -cw
echo > ~/.bash_history
rm -fr /root/.bash_history

# 9. Cloud Init Nuclear Option
echo '> 9. Cloud Init Nuclear Option'
rm -rf /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg
rm -rf /etc/cloud/cloud.cfg.d/99-installer.cfg
echo "disable_vmware_customization: false" >> /etc/cloud/cloud.cfg
echo "# to update this file, run dpkg-reconfigure cloud-init
datasource_list: [ VMware, OVF, None ]" > /etc/cloud/cloud.cfg.d/90_dpkg.cfg

# 10. Set boot options to not override what we are sending in cloud-init.
echo '> 10. Modifying grub ...'
sed -i -e "s/GRUB_CMDLINE_LINUX_DEFAULT=\"\(.*\)\"/GRUB_CMDLINE_LINUX_DEFAULT=\"\"/" /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg

# 11. Reboot the system if needed
# echo '> 11. Rebooting system ...'
# reboot
EOF

# Change script permissions for execution. #
echo "######################################"
echo "Change script permissions for execution."
echo "######################################"
echo '> Changeing script permissions for execution ...'
sudo chmod +x /tmp/cleanup.sh


# Executes the cleauup script. #
echo "######################################"
echo "Executes the cleauup script."
echo "######################################"
echo '> Executing the cleanup script ...'
sudo /tmp/cleanup.sh

### All done. ### 
echo '> Done.'  

<<COMMENT
# Install docker. #
echo "######################################"
echo "Install Docker"
echo "######################################"
dnf update -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt update -y
apt-cache policy docker-ce
apt install docker-ce -y
groupadd docker
usermod -aG docker vmuser
mkdir ~/testfolder
COMMENT

#nmcli connection modify ens192 ipv4.method auto ipv4.addresses "" ipv4.gateway "" ipv4.dns "" ipv6.method auto
#nmcli connection up ens192

echo '> Packer Template Build -- Complete'
echo "######################################"
echo "Rocky9-Base-Post-Install -- Complete"
echo "######################################"
