#!/bin/sh
# !!! kein reboot innerhalb des scripts

# APT im nichtinteraktiven Modus starten
export DEBIAN_FRONTEND=noninteractive

#DNS service
echo "...shutting down systemd-resolved.service"
# disable native DNS service
systemctl disable --now systemd-resolved.service
#--> disable kills internet access due to missing DNS
# setting up DNS resolvers
echo "...setting up DNS servers"
rm /etc/resolv.conf
cp /vagrant/configs/etc-resolv.conf /etc/resolv.conf

### DNSmasq
# install dnsmasq
apt-get -y install dnsmasq
echo "...starting dnsmasq.service"
#-->service automatically enabled, strated and no longer failing on port 53

#OPTIONAL: configure DNSmasq (DHCP-part)
# when working with vagrant nodes DHCP is not needed, since we will set up static IPs
#cat /vagrant/configs/etc-dnsmasq_append.conf >> /etc/dnsmasq.conf
# enable/start DNSmasq service
#systemctl enable --now dnsmasq.service
# restart DNSmasq service
#systemctl restart dnsmasq.service
#echo "...restarting dnsmasq.service"

# install and configure firehol
apt-get -y install firehol
#copy FW config file
#copy config and default file
cp /vagrant/configs/etc-firehol.conf /etc/firehol/firehol.conf
cp /vagrant/configs/def-firehol.conf /etc/default/firehol
#??? needs ssh rules for clients even in vagrant? Yes it does
# start firehol service
echo "...starting firehol.service"
#activation with "firehol start" needed, instead of systemctl
#systemctl enable --now firehol.service
firehol start

echo "...testing dns resolution of www.google.com"
nslookup www.google.com

### check service states
#systemctl list-unit-files | grep abled
#systemctl | grep running

echo "...end of rt-b provision"
