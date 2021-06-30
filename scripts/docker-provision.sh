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
echo "...setting up routing"
ip route replace default via 192.168.100.2
ip route delete default via 10.0.2.2
ip r
echo "...testing dns resolution of www.google.com"
nslookup www.google.com

# install Docker new
echo "...installing docker"
apt-get -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get -y install docker-ce

# install Docker old
#apt-get -y install docker.io

#systemctl enable --now docker
echo "...adding user"
adduser vagrant docker
#OPTIONAL: shared VBox drives group access
#adduser lokaleradmin vboxsf

echo "...end of docker provision"
