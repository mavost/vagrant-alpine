#!/bin/sh

echo "... starting docker provision"
# source: https://wiki.alpinelinux.org/wiki/Docker#Installation/
# stating with alpine 310 available in 'Community' repo
apk add docker docker-compose
addgroup vagrant docker
rc-update add docker boot
service docker start

echo "... starting docker container"
sleep 1
su vagrant
docker run -d -p 8080:80 docker/getting-started
#docker run -p 80:3000 mavost/urban_docker:latest
echo "... docker provision successful"

