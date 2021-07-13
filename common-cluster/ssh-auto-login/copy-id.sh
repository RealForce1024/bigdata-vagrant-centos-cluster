#!/usr/bin/expect -f

[ ! -f /home/vagrant/.ssh/id_rsa.pub ] && ssh-keygen -t rsa -p '' &>/dev/null

for line in $(cat ~/hostsfile); do
	ip=$(echo $line | cut -d: -f1)
	port=$(echo $line | cut -d: -f2)
	user=$(echo $line | cut -d: -f3)
	pass=$(echo $line | cut -d: -f4)
	echo "========正在提交主机IP为：${ip}免登录========\r"

	expect -c "
            set timeout 5;
            spawn ssh-copy-id -i /home/vagrant/.ssh/id_rsa.pub ${user}@${ip} -p ${port};
            expect {
                \"*assword\" { send \"${pass}\r\";exp_continue}
                \"yes/no\" { send \"yes\r\"; exp_continue }
             } ;
            expect eof
        "
	echo "========主机IP为：${ip}免登录执行完成========\r"
done
