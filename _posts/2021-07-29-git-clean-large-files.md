---
title: "git clean repo with bfg"
description: gitlab doesn't like >100MB files - removing crazy big files
toc: true
comments: true
layout: post
categories: [git]
image: images/git.png
---



[bfg website](https://rtyley.github.io/bfg-repo-cleaner/)



## bfg installation from scratch

install java8

```bash
sudo apt install openjdk-8-jre-headless
java -version
>> openjdk version "1.8.0_312"
>> OpenJDK Runtime Environment (build 1.8.0_312-8u312-b07-0ubuntu1~20.04-b07)
>> OpenJDK 64-Bit Server VM (build 25.312-b07, mixed mode)
```



download bfg.jar

```bash
cd ~
mkdir -p Applications/bfg
cd Applications/bfg
# link from https://rtyley.github.io/bfg-repo-cleaner/
wget https://repo1.maven.org/maven2/com/madgag/bfg/1.14.0/bfg-1.14.0.jar
```



and add an alias to `.bashrc`

```bash
$ grep -n -s bfg .*
.bashrc:95:alias bfg='java -jar ~/Applications/bfg/bfg-1.14.0.jar'
$ source .bashrc
```





## General usage

We will fix `~/git/d059-vld-ic`



## Remove big files

no need to create a clone, we can directly work on our repo

```bash
bfg --strip-blobs-bigger-than 100M ~/git/d059-vld-ic
cd ~/git/d059-vld-ic
git reflog expire --expire=now --all && git gc --prune=now --aggressive
```



Note: if you get a message `Warning : no large blobs matching criteria found in packfiles - does the repo need to be packed?`, you have to launch `git gc`



## Remove big files from protected commits

```bash
Protected commits
-----------------

These are your protected commits, and so their contents will NOT be altered:

 * commit d914f24e (protected by 'HEAD')
```

In that case it is even easier, no need of bfg: 

```bash
git rm --cached <my large file>
git commit --amend -C HEAD
```





## Remove forbidden files such as .mp3, .tar.gz

 need to create a clone, we can directly work on our repo

```bash
$ cd ~/Applications/bfg
java -jar bfg-1.13.0.jar --delete-files '*.mp3' --no-blob-protection ~/git/data-scientist-skills
java -jar bfg-1.13.0.jar --delete-files '*.tar.gz' --no-blob-protection ~/git/data-scientist-skills

git reflog expire --expire=now --all && git gc --prune=now --aggressive
```



## Improve .gitignore

see [git ignore large files](/guillaume_blog/blog/git-ignore-large-files.html)