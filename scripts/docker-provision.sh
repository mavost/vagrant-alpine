#!/bin/sh

# APT im nichtinteraktiven Modus starten
export DEBIAN_FRONTEND=noninteractive

# Systemupgrade
apt-get update && apt-get -y dist-upgrade

# !!! kein reboot innerhalb des scripts

# Docker installieren
apt-get -y install docker.io
systemctl enable --now docker
adduser vagrant docker
