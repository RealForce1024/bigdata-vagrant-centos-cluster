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
export HADOOP_HOME=/home/vagrant/apps/hadoop
export FLINK_HOME=/home/vagrant/apps/flink
export PATH=$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$FLINK_HOME/bin:$PATH
EOF
source /etc/profile

cat >>/root/.bashrc <<EOF
export JAVA_HOME=/home/vagrant/apps/jdk
export HADOOP_HOME=/home/vagrant/apps/hadoop
export FLINK_HOME=/home/vagrant/apps/flink
export PATH=$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$FLINK_HOME/bin:$PATH
EOF
source /root/.bashrc

cat >>.bashrc <<EOF
export JAVA_HOME=/home/vagrant/apps/jdk
export HADOOP_HOME=/home/vagrant/apps/hadoop
export FLINK_HOME=/home/vagrant/apps/flink
export PATH=$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$FLINK_HOME/bin:$PATH
EOF
source .bashrc

#---jdk---
tar -zxvf apps/jdk-8u202-linux-x64.tar.gz -C apps/
mv apps/jdk1.8.0_202 apps/jdk
#rm jdk-8u202-linux-x64.tar.gz

#---hadoop---
tar -zxvf apps/hadoop-2.9.2.tar.gz -C apps/
mv -f apps/hadoop-2.9.2 apps/hadoop
# hadoop env update
cp -r hadoop-env-files/* apps/hadoop/etc/hadoop/
#rm  hadoop-2.9.2.tar.gz

#---flink---
tar -zxvf apps/flink-1.7.1-bin-hadoop28-scala_2.12.tgz -C apps/
mv -f apps/flink-1.7.1 apps/hadoop
# flink env update
cp -r flink-env-files/* apps/flink/conf/

#---ssh---
mv /home/vagrant/sshd_config /etc/ssh/sshd_config
sudo systemctl restart sshd.service
