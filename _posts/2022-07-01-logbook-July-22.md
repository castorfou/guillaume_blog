---
title: "Logbook for July 22"
description: 
toc: true
comments: true
layout: post
categories: [logbook]
image: images/logbook.jpg
---



## Week 26 - July 22

**Friday 7/1**

* continue [deep rl class](/guillaume_blog/blog/deep-rl-class-with-huggingface.html) with unit 4, <u>unity ml agents within huggingface</u>. And there is a link to a page explaining [decision transformers](https://huggingface.co/blog/decision-transformers). Seems quite powerful and could be useful for me.



## Week 27 - July 22

**Wednesday 7/6**

* continue [deep rl class](/guillaume_blog/blog/deep-rl-class-with-huggingface.html) with unit 5, <u>Policy Gradient with PyTorch</u>



## Week 29 - July 22

**Thursday 7/21**

* I would like to host kaggle-like competitions. I have found [EvalAI](https://github.com/Cloud-CV/EvalAI) which could be an option. I could push a competition for my data manufacturing colleagues and for other areas in my company. There is a [comparison](https://github.com/Cloud-CV/EvalAI/tree/202001b582fdc332a062b85c02be228c3dcf2cd2#platform-comparison) with other kind of platforms (both closed and open sourced)
* ~~installing [rancher desktop](https://dev.michelin.com/wsl2/docker-rancher) to test EvalAI~~ I don't have administrator rights anymore, so I have moved to installing [docker in WSL](/guillaume_blog/blog/install-docker-on-WSL.html).

**Friday 7/22**

* based on my docker in WSL installation, I tried to follow [EvalAI](https://github.com/Cloud-CV/EvalAI) instructions. It fails at docker-compose build phase. I have opened a [ticket](https://github.com/Cloud-CV/EvalAI/issues/3775).



## Week 30 - July 22

**Monday 7/25**

As a matter of test, installation of [EvalAI](https://github.com/Cloud-CV/EvalAI) on my linux machine (no issue with corporate FW) using [docker](/guillaume_blog/blog/install-docker-on-linux.html).

When starting, this error: `ERROR: for db Cannot start service db: [...] listen tcp 0.0.0.0:5432: bind: address already in use`. Just kill the running postgres process as explained in [Evalai - Common Errors during installation](https://evalai.readthedocs.io/en/latest/faq(developers).html#q-getting-the-following-error)

**Tuesday 7/26**

As a matter of test, installation of [EvalAI](https://evalai.readthedocs.io/en/stable/setup.html#ubuntu-installation-instructions) on my wsl machine using virtualenv (no docker) to try a gitlab connectivity instead of github. Tried on ubuntu-22.04. And tried on [ubuntu-18.04](/guillaume_blog/blog/install-ubuntu-18.04-on-WSL.html) without success.

**Wednesday 7/27**

Not giving up 😓. Will try this: build docker image from linux, save it. Moved it to my wsl image. Restore it. Pray. [How to copy a Docker image from one server to another without pushing it to a repository first?](https://www.digitalocean.com/community/questions/how-to-copy-a-docker-image-from-one-server-to-another-without-pushing-it-to-a-repository-first)

- from linux: `sudo docker save -o /tmp/evalai_nodejs.tar evalai_nodejs`
- from wsl: 
```bash
sudo mkdir /mnt/e
sudo mount -t drvfs E: /mnt/e
# pv to copy with a progress bar
pv /mnt/e/janus/evalai_nodejs.tar > ~/tmp/evalai_nodejs.tar
sudo docker load -i evalai_nodejs.tar
cd ~/evalai
docker-compose up
```

~~but I don't know how to go further as explained in [this evalai issue](https://github.com/Cloud-CV/EvalAI/issues/3777)~~