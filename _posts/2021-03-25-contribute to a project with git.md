---
title: "Git - How To Contribute To A Project"
description: submit patch, example with clustergit project
toc: true
comments: true
layout: post
categories: [git]
image: images/git.png
---

Based on http://qpleple.com/how-to-contribute-to-a-project-on-github/



## Using clustergit as an example



**Fork**

Make your own working copy of the project by forking it: go on the project page (https://github.com/mnagel/clustergit) and click "Fork". You can access you copy at: https://github.com/castorfou/clustergit



**Clone**

Clone your fork git repository on your local computer:

```bash
git clone git@github.com:castorfou/clustergit.git
```



**Branch**

```bash
git branch master-to-main
git checkout master-to-main
```
This is very important, create one branch per patch. And never submit a patch that has been done on the branch `master` or `main`!



**Develop**

Here I want to reflect change from Oct/20 where default branch name in github is now main

```bash
sed -i 's/master/main/g' clustergit
```



**Commit**

```bash
git add -u
git commit -m "default branch name 'main'"
```



**Push to github**

```bash
git push origin master-to-main
```



**Create pull request**

Go on your fork page (https://github.com/castorfou/clustergit), then select `master-to-main` in the branch list and click "Pull Request".



**Submit patch**

Check the diff, write a message explaining what you have done and why the repository owner should accept your pull request and submit.