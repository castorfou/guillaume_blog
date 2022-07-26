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
* installing conda
```
tmpdir=$(mktemp -d)
cd $tmpdir
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
# answer yes to question Do you wish the installer to initialize Miniconda3 by running conda init?
bash Miniconda3-latest-Linux-x86_64.sh -p $HOME/miniconda3

cat .condarc
ssl_verify: false
shortcuts: false
report_errors: false
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
sudo apt install uwsgi-plugin-python3

cd evalai
# virtualenv venv
# source venv/bin/activate
conda create --name evalai_37  python=3.7
conda activate evalai_37

conda install -c conda-forge uwsgi
conda install -c conda-forge/label/gcc7 uwsgi
conda install -c conda-forge/label/broken uwsgi
conda install -c conda-forge/label/cf201901 uwsgi
conda install -c conda-forge/label/cf202003 uwsgi

sudo apt install gcc-9 gcc-10
sudo rm /usr/bin/gcc
sudo ln -s /usr/bin/gcc-9 /usr/bin/gcc 
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 80 --slave /usr/bin/g++ g++ /usr/bin/g++-11 --slave /usr/bin/gcov gcov /usr/bin/gcov-11
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 60 --slave /usr/bin/g++ g++ /usr/bin/g++-10 --slave /usr/bin/gcov gcov /usr/bin/gcov-10
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 40 --slave /usr/bin/g++ g++ /usr/bin/g++-9 --slave /usr/bin/gcov gcov /usr/bin/gcov-9
sudo update-alternatives --config gcc

conda install -c anaconda gcc_linux-64
conda install -c anaconda  gcc_linux-64==8.2.0


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