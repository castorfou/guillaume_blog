---
title: "save git https credentials under wsl"
description: git-credential-manager 
toc: true
comments: true
layout: post
categories: [git]
image: images/git.png
---

## source of inspiration

Microsoft has released a tool to securely keep https credentials:

[git-credential-manager](https://github.com/GitCredentialManager/git-credential-manager)

Usefull when one has to use https instead of git(ssl) to connect to git repos. My case when I am behing my corporate firewall and has to link to github repos (such as this blog)



## How to setup it

#### create token in github

I have to create a token at Settings > Developer Settings > Personal Access Tokens

#### installation of git-credential-manager inside WSL

Download the latest (v2.0.696 at May/3rd 2022) [.deb package](https://github.com/GitCredentialManager/git-credential-manager/releases/latest), and run the following:

```bash
sudo dpkg -i <path-to-package>
git-credential-manager-core configure
git config --global credential.credentialStore gpg
export GPG_TTY=$(tty)
gpg --full-generate-key
sudo apt install -y pass
pass init 53678326B507576EEE07E341CF56FB960555459C
```

or see the step 06 in [install ubuntu 22.04 on WSL](https://castorfou.github.io/guillaume_blog/blog/install-ubuntu-22.04-on-WSL.html)




