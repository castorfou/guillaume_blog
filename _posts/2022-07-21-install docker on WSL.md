---
title: "install docker within WSL"
description: based on my automatic wsl installation
toc: true
comments: true
layout: post
categories: [wsl]
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
wsl --shutdown ubuntu-docker
```

### setup user configuration

Start ubuntu-docker from Windows Terminal

Follow instructions, don't skip the integration of ssh key in gitlab



That's it for WSL setup, docker can now be installed

# Docker installation

