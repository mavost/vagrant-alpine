#!/bin/sh

echo "... starting basic provision"
# system: https://wiki.alpinelinux.org/wiki/Upgrading_Alpine#Upgrading_to_latest_release
echo "... updating alpine"
apk update
apk add --upgrade apk-tools
apk upgrade --available
# https://linuxx.info/installation-of-alpine-linux/
echo "... adding keymap"
setup-keymap de de

# setting up time zone
# as in https://cduser.com/pique-22-how-to-change-timezone-in-a-linux-alpine-container/
echo "... adding timezone"
apk add tzdata
ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime

echo "... adding other useful modules"
apk add nano

echo "... basic provision successful"

