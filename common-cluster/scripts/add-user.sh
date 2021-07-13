#/usr/bin/bash
username="vagrant"
password="vagrant"
groupexit=$(grep $username /etc/group | wc -l)
if [ $groupexit -eq 0 ]; then
	        groupadd $username
fi
usernameexit=$(grep $username /etc/passwd | wc -l)
if [ $usernameexit -eq 0 ]; then
	        useradd -g $username -m $username -s /bin/bash
	echo "$username:$password" | chpasswd
fi
sudoexit=$(grep $username /etc/sudoers | wc -l)
if [ $sudoexit -eq 0 ]; then
	echo "$username ALL=(ALL)NOPASSWD:ALL" >>/etc/sudoers
fi
echo "Y" | sudo yum -y install sshpass
echo "Y" | sudo yum -y install expect
