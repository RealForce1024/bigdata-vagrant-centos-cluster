# -*- mode: ruby -*-
# vi: set ft=ruby :
#author: TonyFeng



Vagrant.configure("2") do |config|
	(1..3).each do |i|
		config.vm.define "node0#{i}" do |node|
	
		# 设置虚拟机的Box
		node.vm.box = "centos/7"
		# 设置虚拟机的主机名
		node.vm.hostname="node0#{i}"
		# 设置虚拟机本地(即宿主机)使用的IP
		node.vm.network "private_network", ip: "192.168.33.#{i}"

		if i==1
			# hadoop hdfs namenode address 
			node.vm.network "forwarded_port", guest: 9001, host: 9002, protocol: "tcp", id: "hdfs_namenode"
			# hadoop hdfs secondary NameNode web管理端口
			node.vm.network "forwarded_port", guest: 50070, host: 50071, protocol: "tcp", id: "hdfs_secondary_name_node"
			# hadoop yarn resource manager web端口
			node.vm.network "forwarded_port", guest: 8088, host: 8089, protocol: "tcp", id: "yarn_rm_web"
			# flink web界面端口
			node.vm.network "forwarded_port", guest: 8081, host: 8082, protocol: "tcp", id: "flink_web"
			# nc 端口
			node.vm.network "forwarded_port", guest: 9998, host: 9999, protocol: "tcp", id: "nc"
		end
		# 宿主机与虚拟机22端口转发映
		# config.vm.network "forwarded_port", guest: 22, host: "220#{i}"
		node.vm.network "forwarded_port", guest: 22, host: "220#{i}"

		# 设置宿主机与虚拟机的共享目录 (默认当前目录会挂载到虚机主用户目录下/home/vagrant)
		#node.vm.synced_folder "~/Desktop/share", "/home/vagrant/share"

		# 拷贝相应的依赖文件
		config.vm.provision "file", source: "softwares/jdk-8u202-linux-x64.tar.gz", destination: "/home/vagrant/softwares/jdk-8u202-linux-x64.tar.gz"
		config.vm.provision "file", source: "softwares/hadoop-2.9.2.tar.gz", destination: "/home/vagrant/softwares/hadoop-2.9.2.tar.gz"
		config.vm.provision "file", source: "sshd_config", destination: "/home/vagrant/sshd_config"
		config.vm.provision "file", source: "hadoop-env-files", destination: "/home/vagrant/hadoop-env-files"
		config.vm.provision "file", source: "test", destination: "/home/vagrant/test"

		# VirtaulBox相关配置
		node.vm.provider "virtualbox" do |v|
			# 设置虚拟机的名称
			v.name = "node0#{i}"
			# 设置虚拟机的内存大小  
			v.memory = 1024
			# 设置虚拟机的CPU个数
			v.cpus = 1
		end
		# node.vm.provision "shell", inline: $clusters_script # 使用shell脚本进行软件安装和配置
		node.vm.provision "shell", path: "cluster-env.sh" # 使用shell脚本进行软件安装和配置
		end
	end
end
