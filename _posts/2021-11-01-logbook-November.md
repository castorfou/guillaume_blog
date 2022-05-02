---
title: "Logbook for November 21"
description: 
toc: true
comments: true
layout: post
categories: [logbook]
image: images/logbook.jpg
---



## Week 47 - November 21

**Monday 11/22**

back after a nice vacation break + some catchup to do for work.

to use iphone as a webcam on linux or windows: https://www.iriun.com/ (but not detected as a webcam in linux)

**Wednesday 11/24**

getting this message when pushing to gitlab: remote: GitLab: File <my_large_file>  is larger than the allowed size of 100 MB

if from the most recent commit:

```bash
git rm --cached <my large file>
git commit --amend -C HEAD
```

otherwise follow [Tutorial: Removing Large Files from Git](https://medium.com/analytics-vidhya/tutorial-removing-large-files-from-git-78dbf4cf83a) on medium (or [git clean repo with BFG](https://castorfou.github.io/guillaume_blog/blog/git-clean-large-files.html) on this blog)

**Thursday 11/25**

when exporting notebooks with plotly graphs, it can help to use

```python
import plotly
plotly.offline.init_notebook_mode()
```

exporting to html will integrate these plotly graphs (but not exporting to pdf)