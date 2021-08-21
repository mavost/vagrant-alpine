#!/bin/sh

echo "... starting nginx provision"
# source: https://www.cyberciti.biz/faq/how-to-install-nginx-web-server-on-alpine-linux/
apk add nginx
adduser -g 'Nginx www user' -h /home/www/ -D wwwuser
cd /home/www/
ln -s /etc/nginx/nginx.conf nginx.conf
chown -R wwwuser nginx.conf
cp /vagrant_data/configs/nginx.conf /etc/nginx/nginx.conf
cp /vagrant_data/configs/www.docuserver.biz.conf /etc/nginx/conf.d/www.docuserver.biz.conf
rc-update add nginx default
/etc/init.d/nginx start

echo "... cloning docuserver files"
apk add git nano
git clone https://github.com/mavost/docuserver/
chown -R wwwuser docuserver/
echo "... nginx provision successful"

