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