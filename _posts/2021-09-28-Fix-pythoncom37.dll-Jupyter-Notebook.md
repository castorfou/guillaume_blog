---
title: "Fix pythoncom37.dll popup when launching Jupyter Notebook"
description: the procedure entry point ... could not be located in the dynamic library <my_env>\pythoncom37.dll
toc: true
comments: true
layout: post
categories: [jupyter, conda]
image: https://jupyter.readthedocs.io/en/latest/_static/jupyter.svg

---

when having this popup

![https://i.stack.imgur.com/2tQoH.png](https://i.stack.imgur.com/2tQoH.png)



in my case it refers to `stablebaselines3` conda environment.



I just rename `pythoncom37.dll`to `pythoncom37.dll.old` in <home_user>\AppData\Local\Continuum\anaconda3\envs\stablebaselines3\Library\bin

