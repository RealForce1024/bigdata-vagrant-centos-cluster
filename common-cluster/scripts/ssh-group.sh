#/usr/bin/bash

# touch文件需要先在变量前定义，否则会覆盖变量定义(之前变量定义为空)
touch /tmp/sshgen.sh /tmp/sshping.sh
sudo chmod 777 /tmp/sshgen.sh /tmp/sshping.sh

username="vagrant"
password="vagrant"
sshport=22
iplist="192.168.33.1 192.168.33.2 192.168.33.3"
localip=$(ifconfig | grep "192.168" | awk '{print $2}' | sed -r "s/addr://g")

echo "
#/bin/bash
if [ ! -f /home/$username/.ssh/id_rsa ]
then
	echo \"/home/$username/.ssh/id_rsa\"|sudo -u $username ssh-keygen -t rsa -P ''
    if [ $(grep \" $(cat /home/$username/.ssh/id_rsa.pub)\" /home/$username/.ssh/authorized_keys | wc -l) -eq 0 ]
    then
        sudo -u $username cat /home/$username/.ssh/id_rsa.pub >> /home/$username/.ssh/authorized_keys
    fi	
	cat /home/$username/.ssh/id_rsa.pub >> /home/$username/.ssh/authorized_keys
	chmod 600 /home/$username/.ssh/authorized_keys
	chown $username:$username -R /home/$username/.ssh
fi
" >/tmp/sshgen.sh

if [ "$localip" == "$(echo $iplist | awk '{print $1}')" ]; then
	for i in $iplist; do
		    if [ "$localip" != "$i" ]
		        then
		        sshpass -p $password scp -o "StrictHostKeyChecking no" /tmp/sshgen.sh $username@$i:/tmp/sshgen.sh
		        sshpass -p $password ssh $username@$i 'bash /tmp/sshgen.sh'
		    else
		        bash /tmp/sshgen.sh
		    fi
	done
fi

echo "#!/usr/bin/expect" >>/tmp/sshping.sh
for i in $iplist; do
	        sshpass -p $password scp -o "StrictHostKeyChecking no" $username@$i:/home/$username/.ssh/id_rsa.pub ./
	        if [ $(grep "$(cat id_rsa.pub)" /home/$username/.ssh/authorized_keys | wc -l) -eq 0 ]
	        then
	                sudo -u $username cat id_rsa.pub >>/home/$username/.ssh/authorized_keys
	        fi
	ssh-copy-id $i
	#         echo "spawn ssh $username@$i \"echo aaa>/dev/null\"
	# 	expect \"Are you sure you want to continue connecting*\"
	# 	send \"yes\r\"
	# 	expect eof" >>/tmp/sshping.sh
done
