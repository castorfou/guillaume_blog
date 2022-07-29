---
title: "EvalAI and gitlab"
description: host evalai fully internally (UI and code)
toc: true
comments: true
layout: post
categories: [docker, evalai, gitlab, wsl]
---

## source of inspiration

Deploy evalai docker images by [copying from another PC](/guillaume_blog/blog/logbook-July-22.html#week-30---july-22)

[Host challenge using github](https://evalai.readthedocs.io/en/latest/host_challenge.html#host-challenge-using-github)

## Run docker from wsl

```bash
cd ~/evalai
docker-compose up
```



In case of errors:

* `ERROR: for nodejs UnixHTTPConnectionPool(host='localhost', port=None): Read timed out.` Restart docker service and rerun evalai: `sudo service docker restart`



# Host challenge using gitlab

### Create EvalAI-Starters project in gitlab

This project is hosted at [github](https://github.com/Cloud-CV/EvalAI-Starters)

Create a blank project at [gitlab](https://gitlab.michelin.com/janus/EvalAI-Starters)

```bash
#from a WSL image
git clone https://github.com/Cloud-CV/EvalAI-Starters.git
cd EvalAI-Starters
git remote rename origin origin-github
git remote add origin-gitlab git@gitlab.michelin.com:janus/EvalAI-Starters.git
git push -u origin-gitlab --all
git push -u origin-gitlab --tags
```

### Create challenge using gitlab

1. create a repo `test_evalai`for challenge by importing from github

~~Create new project > Create from template > Sample GitLab Project > Use template~~

from github: clone evalai-starters

from gitlab: create new project > import project > GitHub > integrate token > 

select EvalAI-Starters and named it janus/ test_evalai

import

go to project

2. create project access token

repo test_evalai > settings > Access Tokens

Token name : evalai_user_auth_token

Create project access token

(glpat-w8GWL4WqqzgfQsCLRaMZ)

3. setup host configuration

login as host (for the moment: host/password)

go to profile page, get your auth (eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY5MDYyMDYxMywianRpIjoiOWVkOTU2YmU2ZTJkNDNmOWI3Y2M0YTZhOGQ1ODY3ZjIiLCJ1c2VyX2lkIjoyfQ.bO9wp7r17uct4KJbt9hixsOT4nzYAUr-wUZR6PHI0jw)

create a new team Host teams > Create a new team

Team Name: janus

ID is 34

and evalai host url is http://localhost:8888/

4. setup automated update push

Create a branch with name `challenge` in the forked repository from the `master` branch. Note: Only changes in `challenge` branch will be synchronized with challenge on EvalAI.

Add `evalai_user_auth_token` and `host_team_pk` in `github/host_config.json`.

5. update challenge details

Read [EvalAI challenge creation documentation](https://evalai.readthedocs.io/en/latest/configuration.html) to know more about how you want to structure your challenge. Once you are ready, start making changes in the yaml file, HTML templates, evaluation script according to your need.

6. push changes to the challenge





Here I have to move from github actions to gitlab jobs.

Let's locally clone this repo

```bash
git clone git@gitlab.michelin.com:janus/test_evalai.git
cd test_evalai
git branch -a
git checkout challenge
```

- Watch [First time GitLab & CI/CD](https://www.youtube.com/watch?v=kTNfi5z6Uvk&t=1093s). This includes a quick introduction to GitLab, the first steps with CI/CD, building a Go project, running tests, using the CI/CD pipeline editor, detecting secrets and security vulnerabilities and offers more exercises for asynchronous practice.
-  Watch [Intro to GitLab CI](https://www.youtube.com/watch?v=l5705U8s_nQ&t=358s). This workshop uses the Web IDE to quickly get going with building source code using CI/CD, and run unit tests.

1st step is to try with a very simple `.gitlab-ci.yml` file. And use pipeline editor from gitlab to edit it.

Some questions or errors:

* I have been waiting 1 hour for my job to run, and it was simply pending because I had no tags entry and runners on our gitlab catch only tagged CI.
* How to know which images are available in artifactory? Would like to use one with python pre-installed (with version 3.7.5)

I am stuck when having to deal with github action context calls such as ${{ toJSON(github) }}'