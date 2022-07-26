---
title: "install ubuntu 18.04 on WSL and then evalai"
description: could be useful to install evalai
toc: true
comments: true
layout: post
categories: [wsl]
image: images/icons/wsl2.jpeg
---

## source of inspiration

[install ubuntu 22.04 on WSL](/guillaume_blog/blog/install-ubuntu-22.04-on-WSL.html)

[install evalai in ubuntu](https://evalai.readthedocs.io/en/stable/setup.html#ubuntu-installation-instructions)

## Installation ubuntu-18.04

### uninstall image (if needed)

```powershell
# wsl --unregister <distroName>
wsl --unregister ubuntu-18.04
```





### download images

From [cloud images ubuntu](https://cloud-images.ubuntu.com/bionic/current/) (cloud-images > bionic> current), now there are wsl images:

![ubuntu cloud images](https://www.windowscentral.com/sites/wpcentral.com/files/styles/larger/public/field/image/2022/01/ubuntu-cloud-images-website.png)

I just have to download the last bionic (18.04) image `bionic-server-cloudimg-amd64-wsl.rootfs.tar.gz`



### install and setup from powershell

I have downloaded this ubuntu image to `D:\wsl\ubuntu-18.04\download`

```bash
(base) guillaume@LL11LPC0PQARQ:/mnt/d/wsl$ tree
.
├── Ubuntu-20.04
│   └── ext4.vhdx
├── Ubuntu-22.04
│   ├── download
│   │   └── jammy-server-cloudimg-amd64-wsl.rootfs.tar.gz
│   └── instance
```

and my `ubuntu-18.04` instance will stand in `D:\wsl\ubuntu-18.04\instance`



Install with this command from powershell

```powershell
# wsl --import <distroname> <location of instance> <location of download>
wsl --import ubuntu-18.04 D:\wsl\ubuntu-18.04\instance D:\wsl\ubuntu-18.04\download\bionic-server-cloudimg-amd64-wsl.rootfs.tar.gz
```

It takes 3-4 minutes to install. and should be visible in your wsl instances.

```powershell
 wsl --list --all -v
  NAME            STATE           VERSION
  ubuntu-22.04    Stopped         2
```



then to run it

```powershell
# wsl -d <distroname>
wsl -d ubuntu-18.04
```

or

#### use Windows Terminal as a launcher

Windows Terminal is a smart way to group all terminals (powershell, and all your wsl instances)

![windows terminal](../images/windows_terminal.jpg)

It can be installed even with limited windows store access by clicking install in [Installer le Terminal Windows et commencer à le configurer](https://docs.microsoft.com/fr-fr/windows/terminal/install)

Automatically all wsl instances appear in Settings.



## Automatic setup

copy these 2 [scripts](https://github.com/castorfou/guillaume_blog/tree/master/files) in /root/ (given they are in `D:\wsl\ubuntu-18.04\download`)

```bash
cp /mnt/d/wsl/Ubuntu-18.04/download/setup_wsl_* .
```



`setup_wsl_root.sh` [download](../files/setup_wsl_root.sh)

```bash
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
```

`setup_wsl_user.sh` [download](../files/setup_wsl_user.sh)

```bash
#!/bin/bash

echo "1. setup wsl-vpnkit"
if grep -Fxq "wsl-vpnkit" ~/.profile
then
    # code if found
	echo "   wsl-vpnkit already setup"
else
    # code if not found
	echo 'wsl.exe -d wsl-vpnkit service wsl-vpnkit start' >> ~/.profile
fi
wsl.exe -d wsl-vpnkit service wsl-vpnkit start
source ./.bashrc
echo

echo "2. create ssh key to copy to gitlab"
. /etc/lsb-release
if [ ! -e ".ssh/id_rsa.pub" ]; then
		ssh-keygen -t rsa -b 4096 -C "WSL2 ubuntu $DISTRIB_RELEASE"
		cat .ssh/id_rsa.pub
		echo "copy this content to gitlab > preferences > SSH Keys"
		read -p "Press any key to resume ..."
fi
echo

echo "3. update certificates"
git clone git@gitlab.michelin.com:devops-foundation/devops_environment.git /tmp/devops_environment
sudo cp /tmp/devops_environment/certs/* /usr/local/share/ca-certificates/
sudo update-ca-certificates
rm -rf /tmp/devops_environment
if [ $DISTRIB_RELEASE == "22.04" ]
then
echo 'bug SSL with ubuntu 22.04 - https://bugs.launchpad.net/ubuntu/+source/openssl/+bug/1963834/comments/7'
sudo tee -a /etc/ssl/openssl.cnf << EOF
[openssl_init]
ssl_conf = ssl_sect

[ssl_sect]
system_default = system_default_sect

[system_default_sect]
Options = UnsafeLegacyRenegotiation
EOF
fi
echo

echo "4. update apt sources with artifactory"
echo 'Acquire { http::User-Agent "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:13.37) Gecko/20100101 Firefox/31.33.7"; };' | sudo tee /etc/apt/apt.conf.d/90globalprotectconf
sudo sed -i 's,http://archive.ubuntu.com/ubuntu,https://artifactory.michelin.com/artifactory/ubuntu-archive-remote,g' /etc/apt/sources.list
sudo sed -i 's,http://security.ubuntu.com/ubuntu,https://artifactory.michelin.com/artifactory/ubuntu-archive-remote,g' /etc/apt/sources.list
sudo apt update
sudo apt upgrade -y
echo
```

Then 

```bash
chmod +x setup_wsl_root.sh
./setup_wsl_root.sh
```

As explained stop wsl instance by running `wsl --shutdown ubuntu-22.04` from powershell
and start from Windows Terminal

It restarts from your user and it will install:

* setup wsl-vpnkit
* create ssh key to copy to gitlab
* update certificates
* update apt sources with artifactory



## Installation EvalAI

###### Step 1: Install prerequisites

* Install git - postgres

```
sudo apt-get install git postgresql libpq-dev
```

* install rabbit-mq

```bash
sudo apt-get -y install socat logrotate init-system-helpers adduser erlang-base erlang-base-hipe esl-erlang
# download the package
wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.10.6/rabbitmq-server_3.10.6-1_all.deb

# install the package with dpkg
sudo dpkg -i rabbitmq-server_3.10.6-1_all.deb
rm rabbitmq-server_3.10.6-1_all.deb
```
* installing conda
```
tmpdir=$(mktemp -d)
cd $tmpdir
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
# answer yes to question Do you wish the installer to initialize Miniconda3 by running conda init?
bash Miniconda3-latest-Linux-x86_64.sh -p $HOME/miniconda3

cat .condarc
ssl_verify: false
shortcuts: false
report_errors: false
```

* install virtualenv
```bash
# only if pip is not installed
sudo apt-get install python3-pip build-essential
# upgrade pip, not necessary
sudo pip install --upgrade pip
# upgrade virtualenv
pip install --upgrade virtualenv
```

###### Step 2: Get EvalAI code

```bash
git clone https://github.com/Cloud-CV/EvalAI.git
```

###### Step 3: Setup codebase

- Create a python virtual environment and install python dependencies.

```
#pour curl-config
sudo apt install libcurl4-openssl-dev libssl-dev
sudo apt install uwsgi-plugin-python3

cd evalai
# virtualenv venv
# source venv/bin/activate
conda create --name evalai_37  python=3.7
conda activate evalai_37

conda install -c conda-forge uwsgi
conda install -c conda-forge/label/gcc7 uwsgi
conda install -c conda-forge/label/broken uwsgi
conda install -c conda-forge/label/cf201901 uwsgi
conda install -c conda-forge/label/cf202003 uwsgi

sudo apt install gcc-9 gcc-10
sudo rm /usr/bin/gcc
sudo ln -s /usr/bin/gcc-9 /usr/bin/gcc 
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 80 --slave /usr/bin/g++ g++ /usr/bin/g++-11 --slave /usr/bin/gcov gcov /usr/bin/gcov-11
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 60 --slave /usr/bin/g++ g++ /usr/bin/g++-10 --slave /usr/bin/gcov gcov /usr/bin/gcov-10
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 40 --slave /usr/bin/g++ g++ /usr/bin/g++-9 --slave /usr/bin/gcov gcov /usr/bin/gcov-9
sudo update-alternatives --config gcc

conda install -c anaconda gcc_linux-64
conda install -c anaconda  gcc_linux-64==8.2.0


pip --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org install -r requirements/dev.txt
# issue on django-autofixture 
# https://github.com/gregmuellegger/django-autofixture/issues/117
```

- Rename `settings/dev.sample.py` as `dev.py`

```
cp settings/dev.sample.py settings/dev.py
```

- Create an empty postgres database and run database migration.

```
createdb evalai -U postgres
# update postgres user password
psql -U postgres -c "ALTER USER postgres PASSWORD 'postgres';"
# run migrations
python manage.py migrate
```

- For setting up frontend, please make sure that node(`>=7.x.x`), npm(`>=5.x.x`) and bower(`>=1.8.x`) are installed globally on your machine. Install npm and bower dependencies by running

```
npm install
bower install
```