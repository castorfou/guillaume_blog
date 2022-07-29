---
title: "install docker within WSL"
description: based on my automatic wsl installation
toc: true
comments: true
layout: post
categories: [wsl, docker]
image: images/icons/wsl2.jpeg
---

## source of inspiration

[WSL 2 Docker inside WSL 2](https://dev.michelin.com/wsl2/docker)

[install ubuntu 22.04 on WSL](/guillaume_blog/blog/install-ubuntu-22.04-on-WSL.html)



## Pre-requisite Installation - ubuntu-docker

### uninstall image (if needed)

```powershell
# wsl --unregister <distroName>
wsl --unregister ubuntu-docker
```



### setup installation directory

create this structure by copying the existing one from `ubuntu-22.04`

```bash
guillaume@LL11LPC0PQARQ:/mnt/d/wsl/Ubuntu-docker$ tree
.
└── download
    ├── GWSL.Traditional.140.release.x64.exe
    ├── ZscalerRootCA.crt
    ├── jammy-server-cloudimg-amd64-wsl.rootfs.tar.gz
    ├── setup_wsl_root.sh
    └── setup_wsl_user.sh
```

### create ubuntu-docker image 

from Powershell

```powershell
wsl --import ubuntu-docker D:\wsl\ubuntu-docker\instance D:\wsl\ubuntu-docker\download\jammy-server-cloudimg-amd64-wsl.rootfs.tar.gz

#should appear in 
wsl --list --all -v
```

### declare ubuntu-docker in Windows Terminal

Windows Terminal > Settings > Add a profile > Duplicate a profile (from Ubuntu-22.04)

Name: `ubuntu-docker`

Command line: `C:\WINDOWS\system32\wsl.exe -d ubuntu-docker`

Tab title: `ubuntu docker`

### setup root configuration

Start ubuntu-docker from Windows Terminal

```bash
cp /mnt/d/wsl/Ubuntu-docker/download/setup_wsl_* .
chmod +x setup_wsl_root.sh
./setup_wsl_root.sh
```

enter username and password

From powershell, stop ubuntu-docker

```powershell
wsl -t ubuntu-docker
```

### setup user configuration

Start ubuntu-docker from Windows Terminal

Follow instructions, don't skip the integration of ssh key in gitlab



```bash
guillaume@LL11LPC0PQARQ:~$ host google.fr
google.fr has address 142.250.75.227
google.fr has IPv6 address 2a00:1450:4007:811::2003
Host google.fr not found: 3(NXDOMAIN)
```



That's it for WSL setup, docker can now be installed



# Docker installation

```bash
curl  https://artifactory.michelin.com/artifactory/mt-generic-prod/devops-environment/install.sh -o install.sh
```

Edit install.sh

- line 246: add 22 as a support for ubuntu 22.04

`declare -A support_matrix=(["debian"]="10 11" ["ubuntu"]="18 20")`

* comment lines 297 to 301 

`#configure_vpn_kit
#configure_wsl_dns
#install_cacert
#configure_apt_global "$os"
#configure_apt_artifactory "$os"`

* insert docker list (line 40) 

```bash
source /etc/os-release
curl -fsSL https://download.docker.com/linux/${ID}/gpg | sudo apt-key add -
echo "deb [arch=amd64] https://artifactory.michelin.com/artifactory/ubuntu-docker-remote jammy stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
```



And run it

```bash
chmod +x install.sh
./install.sh --no-dev --no-dev-tools --no-swag --no-swagerino --no-kube --skip-update
```



Activate legacy for iptables

```bash
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
```



Then start docker service

```bash
sudo service docker start
```



Before restarting, ensure your `wsl.conf` is correct (remove network-generateResolvConf entry and add user-default one):

```bash
guillaume@LL11LPC0PQARQ:~$ cat /etc/wsl.conf
[user]
default=guillaume
```

Restart

# Test installation

```bash
docker run docker.artifactory.michelin.com/hello-world
> Hello from Docker!
> This message shows that your installation appears to be working correctly.
```

