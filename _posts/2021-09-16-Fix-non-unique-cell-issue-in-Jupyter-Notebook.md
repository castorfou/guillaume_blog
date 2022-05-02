---
title: "Fix non-unique cell issue in Jupyter Notebook"
description: when copy/paste in jupyter is breaking your notebooks
toc: true
comments: true
layout: post
categories: [jupyter]
image: https://jupyter.readthedocs.io/en/latest/_static/jupyter.svg

---

subject is explained in [https://github.com/jupyter/notebook/issues/6001](https://github.com/jupyter/notebook/issues/6001)



```python
import nbformat as nbf
from glob import glob

import uuid
def get_cell_id(id_length=8):
    return uuid.uuid4().hex[:id_length]

# your notebook name/keyword
nb_name = '04 - data analysis from dataprophet - W34.ipynb'
notebooks = list(filter(lambda x: nb_name in x, glob("./*.ipynb", recursive=True)))

# iterate over notebooks
for ipath in sorted(notebooks):
    # load notebook
    ntbk = nbf.read(ipath, nbf.NO_CONVERT)
    
    cell_ids = []
    for cell in ntbk.cells:
        cell_ids.append(cell['id'])

    # reset cell ids if there are duplicates
    if not len(cell_ids) == len(set(cell_ids)): 
        for cell in ntbk.cells:
            cell['id'] = get_cell_id()

    nbf.write(ntbk, ipath)
```

