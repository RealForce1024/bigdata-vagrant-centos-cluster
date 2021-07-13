#!/bin/bash

# at /home/vagrant
#---hosts---
cat >>/etc/hosts <<EOF

192.168.33.1  node01
192.168.33.2  node02
192.168.33.3  node03

EOF

#---env---
cat >>/etc/profile <<EOF
export JAVA_HOME=/home/vagrant/apps/jdk
export PATH=$JAVA_HOME/bin:$PATH
EOF
source /etc/profile

cat >>/root/.bashrc <<EOF
export JAVA_HOME=/home/vagrant/apps/jdk
export PATH=$JAVA_HOME/bin:$PATH
EOF
source /root/.bashrc

cat >>.bashrc <<EOF
export JAVA_HOME=/home/vagrant/apps/jdk
export PATH=$JAVA_HOME/bin:$PATH
EOF
source .bashrc

#---jdk---
tar -zxvf apps/jdk-8u202-linux-x64.tar.gz -C apps/
mv apps/jdk1.8.0_202 apps/jdk
#rm jdk-8u202-linux-x64.tar.gz

#---ssh---
mv /home/vagrant/sshd_config /etc/ssh/sshd_config
sudo systemctl restart sshd.service

sudo chown -R vagrant:vagrant  /home/vagrant/apps/jdk 
