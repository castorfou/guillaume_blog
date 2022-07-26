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

As a matter of test, installation of [EvalAI](https://github.com/Cloud-CV/EvalAI) on my linux machine (no issue with corporate FW) using docker

**Tuesday 7/26**

As a matter of test, installation of [EvalAI](https://evalai.readthedocs.io/en/stable/setup.html#ubuntu-installation-instructions) on my wsl machine using virtualenv (no docker) to try a gitlab connectivity instead of github

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
cd evalai
virtualenv venv
source venv/bin/activate
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