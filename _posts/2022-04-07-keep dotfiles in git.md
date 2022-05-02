---
title: "keep dotfiles in git"
description: as pointed by Jeremy Howard 
toc: true
comments: true
layout: post
categories: [git]
image: images/git.png
---

## source of inspiration

as [pointed](https://www.atlassian.com/git/tutorials/dotfiles) by Jeremy Howard.



## How to setup it

#### prerequisites

I consider I already have a git repo with my dotfiles from other machines.

Repo: `git@<your_gitlab_address>:<your_id>/dotfiles.git`

I keep one separate branch per machine. Current branches: master (empty), and WSL2.

I am going to add a machine called iolab.



#### from iolab

```bash
git init --bare $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bash_aliases
```

And we can now run `config status`

```bash
(base) [ 09:53:56 ][ id: ~ ]$ config status
# On branch master
#
# Initial commit
#
nothing to commit (create/copy files and use "git add" to track)
```

but now we would like to create a new branch, and push all this to our central repo.

First we have to set this central repo.

```bash
config remote add origin git@<your_gitlab_address>:<your_id>/dotfiles.git
config fetch
```

Before creating our branch, we have to commit something (to really create our local branch master)

```bash
config add .bashrc
config commit -m 'init with .bashrc'
```

And then only we can create our branch iolab

```bash
config branch iolab
config checkout iolab
config push --set-upstream origin iolab
```

we are now ready to use it



## How to use it

```bash
config add .bash_aliases
config commit -m'bash aliases'
config push
```



## How to setup 2 remote repo

There is a nice explanation abut how to work with multiple repos in [https://jigarius.com/blog/multiple-git-remote-repositories](https://jigarius.com/blog/multiple-git-remote-repositories).

To follow that, I will configure my dotfile repo from WSL2 to push to 2 remotes, one on gitlab (internal) and one on github.



For the moment it is only connected to gitlab.

```bash
$ config remote -v
origin	git@gitlab.michelin.com:janus/dotfiles.git (fetch)
origin	git@gitlab.michelin.com:janus/dotfiles.git (push)
```

My github repo is at: https://github.com/castorfou/dotfiles.git (I use https, because of my local firewall)

```bash
$ config remote set-url --add --push origin git@gitlab.michelin.com:janus/dotfiles.git
$ config remote set-url --add --push origin https://github.com/castorfou/dotfiles.git
$ config push origin GR_WSL2
```

I have to get a token from github to access in https

To generate a token:

1. Log into **GitHub**
2. Click on your name / Avatar in the upper right corner and select **Settings**
3. On the left, click **Developer settings**
4. Select **Personal access tokens** and click **Generate new token**
5. Give the token a description/name and select the scope of the token
   - I selected **repo** only to facilitate pull, push, clone, and commit actions
   - Click the link **Read more about OAuth scopes** for details about the permission sets
6. Click **Generate token**
7. Copy the token – this is your new password!

Lastly, to ensure the local computer remembers the token, we can  enable caching of the credentials. This configures the computer to  remember the complex token so that we dont have too.

`git config --global credential.helper cache`
