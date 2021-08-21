# Basic NGINX web server virtualized
project realized using the following components:
- runs on an lean Linux Alpine box

- virtual machine is deployed using Vagrant IAC

- Vagrant uses the non-standard libvirt provider, i.e. QEMU/KVM hypervisor

- due to lack of experience NGINX set up is very basic

- sample website is fetched from a generic code repository using git

- host system is Ubuntu 20.04 LTS

![alt text][img01]

## requirements on host
1. QEMU/KVM hypervisor with a bridged interface

2. installing Vagrant and libvirt plugins

3. adjusting the IP and MAC settings in **Vagrantfile** script and **SERVER.conf** file to match with local network settings

4. adding VM IP/hostname to router */etc/hosts* settings for convenience

5. adapting the target for the git clone  
or  
providing content for the web-hosting within the project folder to be copied or linked to /home/www during **nginx_provision.sh** provisioning

6. bringing the machine up exporting the VAGRANT_DEFAULT_PROVIDER=libvirt variable and `vagrant up`  
or  
`vagrant up --provider=libvirt `


[img01]:  ./images/webserver.jpg "Example webpage"