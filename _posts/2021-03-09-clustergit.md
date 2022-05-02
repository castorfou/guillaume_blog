---
title: "Git - How to find all *unpushed* commits for all projects in a directory?"
description: clustergit, RabbitVCS - installation and usage
toc: true
comments: true
layout: post
categories: [git]
image: images/git.png
---

Very basic question to help keep my repo clean.



## Installation clustergit

[clustergit](https://github.com/mnagel/clustergit) seems a good candidate

![](https://raw.githubusercontent.com/mnagel/clustergit/master/doc/clustergit.png)



```bash
cd ~/Applications
git clone git@github.com:mnagel/clustergit.git
# add export PATH="$PATH:$HOME/Applications/clustergit" to ~.bashrc
source ~.bashrc
```

or using `.local/bin`

```bash
cd ~/Applications/
git clone git@github.com:castorfou/clustergit.git
cd ~
mkdir -p .local/bin
cd .local/bin/
ln -s ~/Applications/clustergit/clustergit .
source .profile
```





## Usage clustergit

**clustergit status**

```bash
$ clustergit 
Scanning sub directories of .
./Deep-Reinforcement-Learning-Hands-On  : Changesn .    (1/17)
./Deep_reinforcement_learning_Course    : Changes
./ReinforcementLearning_references      : On branch main, Untracked files
./blog                                  : Untracked files
./d059                                  : On branch main, Changes
./data-scientist-skills                 : Clean
./deeplearning_specialization           : Clean
./fastai                                : Changes
./fastai_experiments                    : Changes
./fastbook                              : Changes
./gan_specialization                    : Clean
./hello_nbdev                           : Clean
./introduction-reinforcement-learning-david-silver: On branch main, Untracked files
./mit_600.2x Introduction to Computational Thinking and Data Science: Clean
./mit_6S191_Intro_to_deep_learning      : On branch main, No Changes
./pytorch_tutorial                      : On branch main, Changes
./squeezebox                            : On branch main, No Changes
Done

```

**clustergit status (detailed)**

```bash
$ clustergit -v
[...]
---------------- ./squeezebox -----------------
running  LC_ALL=C git status
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean

./squeezebox                            : On branch main, No Changes
---------------- ./squeezebox -----------------
Done
```



**clustergit status (less detailed: hide Clean)**

```bash
$ clustergit -H
Scanning sub directories of .
./d059                                  : On branch main, Changes
./fastai                                : Changes
./fastai_experiments                    : Changes
./fastbook                              : Changes
./introduction-reinforcement-learning-david-silver: On branch main, Untracked files
./mit_6S191_Intro_to_deep_learning      : On branch main, No Changes
./pytorch_tutorial                      : On branch main, Changes
./squeezebox                            : On branch main, No Changes
Done
```







**Clean** vs **On branch main, No Changes**

seems related to branch name. If branch is named master, then clean is displayed.

(Mar/25 21) I have just changed clustergit to have `main` as default branch name instead of `master` (github having set `main` as the new standard)

Rename everything from master to main



**Git pull, push**

I am not sure I will use it. But allows to recursively launch pull commands to update repos (if no local changes)



## Rename branches from *main* to *master*

[Renaming a branch](https://docs.github.com/en/github/administering-a-repository/renaming-a-branch) from github website.

Rename branch main to master from github website 

![](https://docs.github.com/assets/images/help/branches/branches-link.png)

Update local clones

```bash
git branch -m main master
git fetch origin
git branch -u origin/master master
```



## Rename branches from master to *main* (I know)

[Renaming a branch](https://docs.github.com/en/github/administering-a-repository/renaming-a-branch) from github website.

Rename branch master to main from github website 

![](https://docs.github.com/assets/images/help/branches/branches-link.png)

Update local clones

```bash
git branch -m master main
git fetch origin
git branch -u origin/main main
```



## RabbitVCS

From this [page](https://www.addictivetips.com/ubuntu-linux-tips/integrate-git-with-gnome-file-manager-on-linux/)

*Installation*

```bash
sudo apt install rabbitvcs-nautilus
```

*Result*

![](https://cloud.addictivetips.com/wp-content/uploads/2018/10/rvcs-update-e1540364222288.png)

These overlay icons are not automatically updated (have to hit Ctrl-F5, it is a cache issue?) Which is not a surprise: number of actions are fired based on file modifications, and here status (commited, pushed) is not at all linked to file modifications. The system doesn't know that overlay icon should be changed because file was not touched.

## git-nautilus-icons

Just to check if it works better than RabbitVCS regarding overlay icon cache issue.

No I didn't manage to make it work. Back to RabbitVCS.



## Activate git with GlobalProtect

**move from ssh to https, keeping password**

```bash
$ git remote -v
origin  git@github.com:castorfou/guillaume_blog.git (fetch)
origin  git@github.com:castorfou/guillaume_blog.git (push)
```

move to https://github.com/castorfou/guillaume_blog.git

```bash
git remote set-url origin https://github.com/castorfou/guillaume_blog.git
```

- Make Git store the username and password and it will never ask for them.

```bash
git config --global credential.helper store
```

- Save the username and password for a session (cache it);

```bash
git config --global credential.helper cache
```



and to activate trace

```bash
$ GIT_TRACE_PACKET=1 GIT_TRACE=1 GIT_CURL_VERBOSE=1 git fetch
```

we can enrich certificates with Global Protect CA

```bash
~/anaconda3/ssl$ sudo cp certPG.pem /etc/ssl/certs/
```



## Add a ca-certificate in ubuntu

1. Go to `/usr/local/share/ca-certificates/`
2. Create a new folder, i.e. `sudo mkdir school`
3. Copy the . crt file into the school folder.
4. Make sure the permissions are OK (755 for the folder, 644 for the file)
5. Run `sudo update-ca-certificates`

We should see effects in `/etc/ssl/certs`

```bash
/etc/ssl/certs$ ll -tr
[..]
lrwxrwxrwx 1 root root     86 mars  24 10:02  cert_M_X5C_sase-net-sslfwd-trust-ca.pem -> /usr/local/share/ca-certificates/globalprotect/cert_M_X5C_sase-net-sslfwd-trust-ca.crt
lrwxrwxrwx 1 root root     39 mars  24 10:02  0dc7de9e.0 -> cert_M_X5C_sase-net-sslfwd-trust-ca.pem
```

