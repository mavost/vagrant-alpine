#!/bin/sh

# APT im nichtinteraktiven Modus starten
#!!!no blanks between key, '=', and value
export DEBIAN_FRONTEND=noninteractive

# Systemupgrade
apt-get update && apt-get -y dist-upgrade
apt-get --purge -y autoremove

# set up time zone
# as in https://stackoverflow.com/questions/8671308
ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata
