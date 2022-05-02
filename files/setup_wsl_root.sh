#!/bin/bash

echo "0. get username: "
read user_name

. /etc/lsb-release

echo Configuration for user [$user_name]
echo of distribution $DISTRIB_CODENAME
echo

echo "1. create user and add in sudo"
#adduser --disabled-password --gecos "" $user_name
adduser --gecos "" $user_name
usermod -aG sudo $user_name
echo

echo "2. create wsl.conf file"
rm -rf /etc/wsl.conf
tee /etc/wsl.conf << EOF
# Set the user when launching a distribution with WSL.
[user]
default=$user_name
EOF
echo

echo "3. prepare setup by user"
cp setup_wsl_user.sh /home/$user_name
chown $user_name:users /home/$user_name/setup_wsl_user.sh
chmod 750  /home/$user_name/setup_wsl_user.sh
tee -a /home/$user_name/.bashrc << EOF
if [ ! -e ".wsl_configured" ]; then
		./setup_wsl_user.sh
        touch .wsl_configured
fi
EOF
echo

echo "end of configuration for root"
echo "stop wsl instance by running 'wsl --shutdown <distroname>' from powershell"
echo "and start from Windows Terminal"