---
title: "git ignore large files"
description: gitlab doesn't like >100MB files
toc: true
comments: true
layout: post
categories: [git]
image: images/git.png
---



## files used

```bash
$ ll .gitignore* update_git_ignore.sh
 .gitignore
 .gitignore_bigfiles
 .gitignore_static
 update_git_ignore.sh
```



#### .gitignore_static

Here is my standard entries for `.gitignore`

```bash
$ cat .gitignore_static
*.history
*/.ipynb_checkpoints/*
.ipynb_checkpoints/*
mlflow/*
mlruns/*
```



#### .gitignore_bigfiles, .gitignore

Those are filed created by `update_git_ignore.sh`



###### update_git_ignore.sh

add all files > 100MB in `.gitignore_bigfiles`

merge  `.gitignore_static` and `.gitignore_bigfiles` as `.gitignore`

display `.gitignore`

```bash
$ cat update_git_ignore.sh
#!/bin/bash

#update gitignore_bigfiles
find . -size +100M -not -path "./.git*"| sed 's|^\./||g' | cat > .gitignore_bigfiles

# create gitignore as concat of gitingore_static and gitignore_bigfiles
cat .gitignore_static .gitignore_bigfiles > .gitignore

# print content of .gitignore_bigfiles
cat .gitignore_bigfiles
```



## Usage

Launch `./update_git_ignore.sh`before adding files to `git`

```bash
$ ./update_git_ignore.sh
mlflow/1/5699a81e1a6a44ef8afecd98fff987fc/artifacts/Data Profile.html
$ git add .
$ git commit -m 'example without large files'
```

