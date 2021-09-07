#!/bin/bash

# at /home/vagrant
#---hosts---
cat >>/etc/hosts <<EOF

# nameserver
# 192.168.33.1 rocketmq-nameserver01 
# 192.168.33.3 rocketmq-nameserver02 

# broker
192.168.33.1 node01 rocketmq01 rocketmq-master01 rocketmq-nameserver01
192.168.33.2 node02 rocketmq02 rocketmq-slave01
192.168.33.3 node03 rocketmq03 rocketmq-master02 rocketmq-nameserver02
192.168.33.4 node04 rocketmq04 rocketmq-slave02

EOF

#---env---
cat >>/etc/profile <<EOF
export JAVA_HOME=/home/vagrant/apps/jdk
export ROCKET_HOME=/home/vagrant/apps/rocketmq
export PATH=$JAVA_HOME/bin:$ROCKET_HOME/bin:$PATH
EOF
source /etc/profile

cat >>/root/.bashrc <<EOF
export JAVA_HOME=/home/vagrant/apps/jdk
export ROCKET_HOME=/home/vagrant/apps/rocketmq
export PATH=$JAVA_HOME/bin:$ROCKET_HOME/bin:$PATH
EOF
source /root/.bashrc

cat >>.bashrc <<EOF
export JAVA_HOME=/home/vagrant/apps/jdk
export ROCKET_HOME=/home/vagrant/apps/rocketmq
export PATH=$JAVA_HOME/bin:$ROCKET_HOME/bin:$PATH
EOF
source .bashrc

#---jdk---
tar -zxvf apps/jdk-8u202-linux-x64.tar.gz -C apps/
mv apps/jdk1.8.0_202 apps/jdk
#rm jdk-8u202-linux-x64.tar.gz


# rocketmq
unzip apps/rocketmq-all-4.9.0-bin-release.zip -d apps/
mv apps/rocketmq-all-4.9.0-bin-release apps/rocketmq


sudo mkdir -p /usr/local/rocketmq/store
sudo mkdir -p /usr/local/rocketmq/store/commitlog
sudo mkdir -p /usr/local/rocketmq/store/consumequeue
sudo mkdir -p /usr/local/rocketmq/store/index
sudo mkdir -p /usr/local/rocketmq/store/config
sudo chmod -R 777 /usr/local/rocketmq/store/

sudo mkdir -p /home/vagrant/store/commitlog
sudo mkdir -p /home/vagrant/store
sudo mkdir -p /home/vagrant/store/commitlog
sudo mkdir -p /home/vagrant/store/consumequeue
sudo mkdir -p /home/vagrant/store/index

# sudo mkdir /usr/local/rocketmq/store-slave
# sudo mkdir /usr/local/rocketmq/store-slave/commitlog
# sudo mkdir /usr/local/rocketmq/store-slave/consumequeue
# sudo mkdir /usr/local/rocketmq/store-slave/index

unzip apps/rocketmq-all-4.9.0-bin-release.zip -d apps/
mv apps/rocketmq-all-4.9.0-bin-release apps/rocketmq
# flink env update
cp -r rocketmq-env-files/2m-2s-async/* apps/rocketmq/conf/2m-2s-async/
cp -r rocketmq-env-files/vm-config/* apps/rocketmq/bin/


#---ssh---
mv /home/vagrant/sshd_config /etc/ssh/sshd_config
sudo systemctl restart sshd.service

sudo chown -R vagrant:vagrant  /home/vagrant/apps/jdk 
