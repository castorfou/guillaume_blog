---
title: "Logbook for January 22"
description: 
toc: true
comments: true
layout: post
categories: [logbook]
image: images/logbook.jpg
---



## Week 1 - January 22

**Monday 1/3**

Will try to use [Zotero](https://www.zotero.org) for managing research papers. Can sync between PC. Seems helpful. My [lib](https://www.zotero.org/guillaumeramelet/library)

**Tuesday 1/4**

Git revert a file to a previous commit

```bash
git log 00\ -\ my_lib.ipynb
git checkout f97406b026bfdf529d2dc4de96224bdfbaa576a8 00\ -\ my_lib.ipynb
```

## Week 2 - January 22

**Monday 1/17**

To update fastai from an existing envt under windows

```bash
conda update -n base -c defaults conda (from base)
conda update fastai -c fastai -c pytorch -c conda-forge -c nvidia (from fastai)
```

To install [mamba](https://github.com/mamba-org/mamba) under WSL2

```bash
conda install mamba -n base -c conda-forge (from base)

then

mamba init
```

To use system CA certificate in WSL2

```bash
export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
```

To install fastai in WSL2 using mamba

```python
mamba install -c fastchan fastai
```

**Thursday 1/20**

Stephane Mallat - collège de France - [Information et complexité](https://www.college-de-france.fr/site/stephane-mallat/course-2022-01-19-09h30.htm) but unfortunately video is not yet available.

Re-read of arXiv:2110.01889 Deep Neural Networks and Tabular Data: A Survey (here on [zotero](https://www.zotero.org/guillaumeramelet/collections/S9YLK8K9/items/V6LWTC5E/collection))

## Week 3 - January 22

**Tuesday 1/26**

Video of 1st lecture of Stephane Mallat 2022 is now available.