#!/bin/sh

# APT im nichtinteraktiven Modus starten
export DEBIAN_FRONTEND=noninteractive

# Systemupgrade
apt-get update && apt-get -y dist-upgrade

# set up time zone
# as in https://stackoverflow.com/questions/8671308
ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata

# !!! kein reboot innerhalb des scripts

### DNSmasq
# install
apt-get -y install dnsmasq
#-->service automatically enabled and started, but failing on port 53
# configure DNSmasq (DHCP-part)
cat /vagrant/configs/dnsmasq_append.conf >> /etc/dnsmasq.conf
# configure DNSmasq (DNS-part)
rm /etc/resolv.conf
cp /vagrant/configs/resolv.conf /etc/.
echo "...shutting down systemd-resolved.service"
# disable native DNS service 
systemctl disable --now systemd-resolved.service
#--> kills internet access
# enable/start DNSmasq service
#systemctl enable --now dnsmasq.service
# restart DNSmasq service
echo "...restarting dnsmasq.service"
systemctl restart dnsmasq.service

# install and configure firehol
apt-get -y install firehol
#copy FW config file
#??? needs ssh rules for clients even in vagrant?
cp /vagrant/configs/firehol.conf /etc/firehol/.
#copy default file
cp /vagrant/configs/firehol-def.conf /etc/default/firehol
# start firehol service
echo "...starting firehol.service"
systemctl enable --now firehol.service
#??? activation with "firehol try" needed?

echo "...testing dns resolution of www.google.com"
nslookup www.google.com

### check service states
#systemctl list-unit-files | grep abled
#systemctl | grep running
