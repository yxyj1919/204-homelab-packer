sed -i 's/^enabled=1/enabled=0/' /etc/yum.repos.d/*.repo
wget -O /etc/yum.repos.d/rocky-local.repo  https://repo.changw.xyz/rocky-local.repo
wget -O /etc/yum.repos.d/epel-local.repo  https://repo.changw.xyz/epel-local.repo
wget -O /etc/yum.repos.d/epel-local.repo  https://repo.changw.xyz/docker-local.repo
yum clean all
yum makecache
#yum update -y
#yum clean all
#nmcli connection modify ens192 ipv4.method auto ipv4.addresses "" ipv4.gateway "" ipv4.dns "" ipv6.method auto
#nmcli connection up ens192