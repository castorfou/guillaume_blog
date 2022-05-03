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

as detailed in [https://github.com/fastai/fastpages/issues/634](https://github.com/fastai/fastpages/issues/634)



Hamel asks to restart from a new repo. But how to keep the same blog url?

Easy way is to rename former repo (from `guillaume_blog` to `guillaume_blog_old`) and initiate new repo as former one (`guillaume_blog`).

Here are the steps.



## Installation and setup



### Installation

1. Generate a copy of [fastpages repo](https://github.com/fastai/fastpages#setup-instructions). Just have to follow instructions by clicking at https://github.com/fastai/fastpages/generate. Name repo as `guillaume_blog`
2. Click on the PR `Initial Setup` in your new repo. There are instructions to create a SSH_DEPLOY_KEY.
3. Merge this PR
4. Clone this repo locally
5. Because I use https, I have to create a token at Settings > Developer Settings > Personal Access Tokens
6. and to keep this token locally, I enter `git config --global credential.helper manager` before pushing



### Copy content

1. Directories: `_notebooks`, `_posts`, `_files`, `_images`
2. Clean content from directories (examples) in  `_notebooks`, `_posts`, `_words`
3. Pages: `_pages/about.md`, `index.html`, `README.md`
4. and utils: `refresh_blog_content.sh`, `publish.sh`



