---
title: "Logbook for September 22"
description: 
toc: true
comments: true
layout: post
categories: [logbook]
image: images/logbook.jpg
---



## Week 36 - September 22

**Monday 9/5**

* Start with fastai courses version [2022](https://course.fast.ai/). Video of [Lesson 1](https://www.youtube.com/watch?v=8SF_h3xF3cE)

**Tuesday 9/6**

Keep backups on an external drive to upgrade PC. Using freefilesync.

* backup files
* sbox
* git (check with clustergit)
* wsl

> from [WSL2 Backup and Restore Images using Import and Export](https://www.virtualizationhowto.com/2021/01/wsl2-backup-and-restore-images-using-import-and-export/)
>
> ```bash
> # from PowerShell
> wsl --list
> > Ubuntu (par défaut)
> > ubuntu-docker
> > ubuntu-18.04
> > ubuntu-22.04
> > wsl-vpnkit
> 
> wsl --shutdown
> 
> wsl --export <Image Name> <Export location file name.tar>
> ```

* installed apps

wsl2, prtscr, vscode, jdiskreport (centre logiciel), accessdatabasenginex64, driver nvidia, freefilesync (centre logiciel), notepad++ (centre logiciel), keepass (centre logiciel), zotero (centre logiciel), Windows Terminal, barrier, GWSL, typora, 

* version windows - 21H2 19044.1889
* tree structure

```cmd
D:\> tree > e:\tree_structure.txt
D:\> xcopy d: e:\t /t /s
```

**Wednesday 9/7**

From time to time when running screen from WSL I have the following error:

```bash
$ screen -dR
Cannot make directory '/run/screen': Permission denied
```

then one can run

```bash
sudo /etc/init.d/screen-cleanup start
```

**Thurdsay 9/8**

Restore backups on this new PC and without administrator rights.

Install of wsl2 following [corporate instructions](https://dev.michelin.com/wsl2/fundamentals)


## Week 37 - September 22

**Thursday 9/15**    
Played a lot with [nbdev2](/guillaume_blog/blog/nbdev2.html). Most thinks work now with gitlab. That's great
    
**Friday 9/16**
Hamel just announced that [fastpages will be discontinued](https://forums.fast.ai/t/fastpages-deprecating-fastpages-in-favor-of-quarto/99095) as nbdev+quarto is now a valid option to provide a blogging platform.
He has written a [migration guide](https://nbdev.fast.ai/tutorials/blogging.html) for that. Will have to follow that.
