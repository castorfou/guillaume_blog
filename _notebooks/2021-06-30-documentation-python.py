#!/usr/bin/env python
# coding: utf-8

# # "Autogenerate documentation from custom python classes"
# > "pdoc3 - installation, generation, browse documentation"
# - show_tags: true
# - toc: true
# - branch: master
# - badges: false
# - comments: true
# - categories: [python]
# - image: https://pdoc3.github.io/pdoc/logo.png

# # Installation
# 

# In[1]:


get_ipython().system('conda env list')


# In[2]:


import sys
get_ipython().system('conda install --yes --prefix {sys.prefix} pdoc3')


# # Generate documentation from .py files

# In[6]:


get_ipython().system('pdoc --html --output-dir /home/explore/git/guillaume/d059/exp/html /home/explore/git/guillaume/d059/exp/init_D059.py')


# This is the way to generate doc:
# 
# ```bash
# pdoc --html --output-dir exp/html exp/my_classe.py
# ```

# ## force refresh of doc
# 
# in case of existing html file

# ```bash
# pdoc --html --output-dir exp/html --force exp/my_classe.py
# ```

# # Example

# <iframe title="Doc" marginheight="0" src="https://castorfou.github.io/guillaume_blog/files/DateFab_NumTombee_Dataset.html" width="800" height="500" frameborder="0">
# </iframe>    

# # Proper docstring to get nice output

# Here is an example that gives good result:
# 
# ```python
#     """
#     Un wrapper de lecture de contenu.
#     En fonction de la nature du fichier (extension), appelle le bon lecteur.
#     Les extensions supportées sont :
#         - .csv : pour appel à pd.read_csv. (Les colonnes Unnamed seront supprimées)
#         - .xls, .xlsx : pour appel à pd.read_excel
#         - .accdb : pour appel à pd.read_sql (disponible uniquement sous Windows)
#     Prend en parametre le nom complet du fichier csv, avec son extension. Et les options à passer.
#     Si un nom de colonne contient Date, le type datetime64 est appliqué.
#     Renvoie le dataframe correspondant.
# 
#     Examples
#     --------
#     >>> getRawContent(root_data+'Stam-CC/MCCSC 25625.csv', sep=';', decimal=',', dayfirst=True)
#     >>> getRawContent(root_data+'Stam-CC/ExportData 25625.xlsx', sheet_name='ExportData 25625 MCCS')
#     >>> getRawContent(root_data +  '/accessDB/Datos 19_12.accdb', tablename='Datos_GR02_25625')
# 
#     Parameters
#     ----------
#     filename : string
#         Emplacement du fichier. Format complet avec l'extension
#         Ex: root_data+'Stam-CC/MCCSC 25625.csv'
#     options : **keyword args, optional
#         Arguments valides dans l'appel à pandas.read_csv, ou pandas.read_excel, ou pandas_read_sql : https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.read_csv.html
#         Ex: sep=';', decimal=',', dayfirst=True
#         Ex: **{'sep':';', 'decimal':',', 'dayfirst':True}
# 
#     Returns
#     -------
#     dataframe
#         Dataframe correspondant au filename avec les options de lecture associées.
#     """
# ```
# 
# that results as
# 
# ![pdoc docstring](../images/pdoc_docstring.jpg)

# In[ ]:




