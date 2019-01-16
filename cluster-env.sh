#!/bin/bash

# at /home/vagrant
#---hosts---
cat >> /etc/hosts <<EOF

192.168.33.1  node01
192.168.33.2  node02
192.168.33.3  node03

EOF
#---env---
cat >> /etc/profile <<EOF
export JAVA_HOME=/home/vagrant/softwares/jdk
export HADOOP_HOME=/home/vagrant/softwares/hadoop
export PATH=$JAVA_HOME/bin:$HADOOP_HOME/bin:$PATH
EOF
source /etc/profile

cat >> /root/.bashrc <<EOF
export JAVA_HOME=/home/vagrant/softwares/jdk
export HADOOP_HOME=/home/vagrant/softwares/hadoop
export PATH=$JAVA_HOME/bin:$HADOOP_HOME/bin:$PATH
EOF
source /root/.bashrc

cat >> .bashrc <<EOF
export JAVA_HOME=/home/vagrant/softwares/jdk
export HADOOP_HOME=/home/vagrant/softwares/hadoop
export PATH=$JAVA_HOME/bin:$HADOOP_HOME/bin:$PATH
EOF
source .bashrc


#---hadoop---
tar -zxvf softwares/hadoop-2.9.2.tar.gz -C softwares/
mv -f softwares/hadoop-2.9.2 softwares/hadoop
# hadoop env update
cp -r hadoop-env-files/*  softwares/hadoop/etc/hadoop/
#rm  hadoop-2.9.2.tar.gz

#---jdk---
tar -zxvf softwares/jdk-8u202-linux-x64.tar.gz -C softwares/
mv softwares/jdk1.8.0_202 softwares/jdk
#rm jdk-8u202-linux-x64.tar.gz


#---ssh---
mv /home/vagrant/sshd_config /etc/ssh/sshd_config
systemctl restart sshd.service


sudo yum install -y epel-release
sudo yum install -y lrzsz.x86_64
sudo yum install -y nmap-ncat.x86_64
sudo yum install -y net-tools
sudo yum install -y vim-enhanced.x86_64
sudo yum install -y sshpass
