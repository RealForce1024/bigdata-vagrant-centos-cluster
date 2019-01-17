#!/bin/bash

# at /home/vagrant

# yum && install
##备份你的原镜像文件，以免出错后可以恢复。
sudo mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
## 下载新的CentOS-Base.repo 到/etc/yum.repos.d/
#sudo wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo
cp /home/vagrant/yum/*.* /etc/yum.repos.d/
mv /etc/yum.repos.d/CentOS7-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo
## 运行yum makecache生成缓存
sudo yum clean all
sudo yum makecache

## install some useful tools
sudo yum install -y iptables-services lsof hstr epel-release lrzsz.x86_64 nmap-ncat.x86_64 net-tools vim-enhanced.x86_64 sshpass wget curl conntrack-tools vim net-tools ntp dos2unix
