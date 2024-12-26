#!/bin/bash
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
#echo '> 5. Setting hostname to localhost ...'
#cat /dev/null > /etc/hostname
#hostnamectl set-hostname localhost

# 6. Cleans apt-get.
echo '> 6. Cleaning apt-get ...'
apt-get clean
apt-get autoremove

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

<<COMMENT
# 9. Cloud Init Nuclear Option
echo `> 9. Cloud Init Nuclear Option`
rm -rf /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg
rm -rf /etc/cloud/cloud.cfg.d/99-installer.cfg
echo "disable_vmware_customization: false" >> /etc/cloud/cloud.cfg
echo "# to update this file, run dpkg-reconfigure cloud-init
datasource_list: [ VMware, OVF, None ]" > /etc/cloud/cloud.cfg.d/90_dpkg.cfg
COMMENT 

# 10. Set boot options to not override what we are sending in cloud-init
echo `> 10. modifying grub`
sed -i -e "s/GRUB_CMDLINE_LINUX_DEFAULT=\"\(.*\)\"/GRUB_CMDLINE_LINUX_DEFAULT=\"\"/" /etc/default/grub
update-grub