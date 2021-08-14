#!/bin/bash

# at /home/vagrant
# change time zone
sudo cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
sudo timedatectl set-timezone Asia/Shanghai

cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
timedatectl set-timezone Asia/Shanghai

# enable ntp to sync time
echo 'sync time'
sudo systemctl start ntpd
sudo systemctl enable ntpd
echo 'disable selinux'
sudo setenforce 0
sudo sed -i 's/=enforcing/=disabled/g' /etc/selinux/config

# 集群时间同步
# 也可以使用下列方式
#config.vm.provision "file", source: "./file/Shanghai", destination: "/tmp/localtime"
#config.vm.provision "shell", inline: "sudo cp /tmp/localtime /etc/localtime"
#config.vm.provision "shell", inline: "sudo ntpdate cn.pool.ntp.org"
