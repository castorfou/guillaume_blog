---
title: "upgrade to last version of fastpages"
description: following bug with pyYaml
toc: true
comments: true
layout: post
categories: [fastpages]
image: images/icons/fastai.png
---

## source of inspiration

as detailed inhttps://github.com/fastai/fastpages/issues/634



Hamel asks to restart from a new repo. But how to keep the same blog url?

Here are the steps.



## Installation and setup



### Installation

1. Generate a copy of [fastpages repo](https://github.com/fastai/fastpages#setup-instructions). Just have to follow instructions by clicking at https://github.com/fastai/fastpages/generate
2. Click on the PR `Initial Setup` in your new repo. There are instructions to create a SSH_DEPLOY_KEY.
3. Merge this PR
4. Clone this repo locally
5. Because I use https, I have to create a token at Settings > Developer Settings > Personal Access Tokens
6. and to keep this token locally, I enter `git config --global credential.helper cache` before pushing



### Copy content

1. Directories: `_notebooks`, `_posts`, `_files`, `_images`
2. Clean content from directories (examples) in  `_notebooks`, `_posts`, `_words`
3. Pages: `_pages/about.md`, `index.html`, `README.md`
4. and utils: `refresh_blog_content.sh`, `publish.sh`



### And complete the configuration to keep our baseurl

by copying `_config.yml`

and editing `_action_files/settings.ini` to update `baseurl`: fastpages expects a match with `baseurl` in `_config.yml` and `_action_files/settings.ini`

