# -*- mode: ruby -*-
# vi: set ft=ruby :
#author: TonyFeng

$clusters_script = <<-SCRIPT
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
tar -zxvf softwares/jdk-8u192-linux-x64.tar.gz -C softwares/
mv softwares/jdk1.8.0_192 softwares/jdk
#rm jdk-8u192-linux-x64.tar.gz


#---ssh---
mv /home/vagrant/sshd_config /etc/ssh/sshd_config
systemctl restart sshd.service

SCRIPT


Vagrant.configure("2") do |config|

		(1..3).each do |i|
			config.vm.define "vm0#{i}" do |node|
		
			# 设置虚拟机的Box
			node.vm.box = "centos/7"
			# 设置虚拟机的主机名
			node.vm.hostname="node0#{i}"
			# 设置虚拟机本地(即宿主机)使用的IP
			node.vm.network "private_network", ip: "192.168.33.#{i}"

			# if i==1
			# 	# hadoop hdfs namenode address 
			# 	config.vm.network "forwarded_port", guest: 9001, host: 9003
			# 	# hadoop hdfs secondary NameNode web管理端口
			# 	config.vm.network "forwarded_port", guest: 50070, host: 50072
			# 	# hadoop yarn resource manager web端口
			# 	config.vm.network "forwarded_port", guest: 8088, host: 8099
			# 	# flink web界面端口
			# 	config.vm.network "forwarded_port", guest: 8081, host: 8083
			# end
			# 宿主机与虚拟机22端口转发映
			# config.vm.network "forwarded_port", guest: 22, host: "220#{i}"

			# 设置宿主机与虚拟机的共享目录 (默认当前目录会挂载到虚机主用户目录下/home/vagrant)
			#node.vm.synced_folder "~/Desktop/share", "/home/vagrant/share"
			
			# 拷贝相应的依赖文件
			config.vm.provision "file", source: "softwares/jdk-8u192-linux-x64.tar.gz", destination: "/home/vagrant/softwares/jdk-8u192-linux-x64.tar.gz"
			config.vm.provision "file", source: "softwares/hadoop-2.9.2.tar.gz", destination: "/home/vagrant/softwares/hadoop-2.9.2.tar.gz"
			config.vm.provision "file", source: "sshd_config", destination: "/home/vagrant/sshd_config"
			config.vm.provision "file", source: "hadoop-env-files", destination: "/home/vagrant/hadoop-env-files"
			config.vm.provision "file", source: "test", destination: "/home/vagrant/test"

			# VirtaulBox相关配置
			node.vm.provider "virtualbox" do |v|
				# 设置虚拟机的名称
				v.name = "vm0#{i}"
				# 设置虚拟机的内存大小  
				v.memory = 1024
				# 设置虚拟机的CPU个数
				v.cpus = 1
			end
			node.vm.provision "shell", inline: $clusters_script # 使用shell脚本进行软件安装和配置
			end
	end
end
