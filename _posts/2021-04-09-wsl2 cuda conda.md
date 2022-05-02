---
title: "setup wsl2 with cuda and conda"
description: best of breed windows + linux
toc: true
comments: true
layout: post
categories: [wsl, cuda, conda]
---



## wsl2 and network + proxychains

workaround explained in [this blog entry](https://castorfou.github.io/guillaume_blog/blog/Windows10-fastai-wsl2-cuda.html#Workaround-network-issue-with-WSL2)

```bash
wsl -d Ubuntu-20.04 sudo ~/Applications/wsl-vpnkit/wsl-vpnkit-main/wsl-vpnkit
```



## cuda

[https://docs.nvidia.com/cuda/wsl-user-guide/index.html#installing-nvidia-drivers](https://docs.nvidia.com/cuda/wsl-user-guide/index.html#installing-nvidia-drivers)

install nvidia cuda specific driver for WSL: [https://developer.nvidia.com/cuda/wsl](https://developer.nvidia.com/cuda/wsl) on windows. (version 470.14_quadro_win10-dch_64bit_international in my case) 



```bash
proxychains wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
sudo proxychains add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
sudo proxychains apt-get update
sudo proxychains apt-get -y install cuda-toolkit-11-2
```



[https://christianjmills.com/Using-PyTorch-with-CUDA-on-WSL2/](https://christianjmills.com/Using-PyTorch-with-CUDA-on-WSL2/)

new version using WSL-ubuntu as distro

[https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=WSLUbuntu&target_version=20&target_type=deblocal](https://christianjmills.com/Using-PyTorch-with-CUDA-on-WSL2/)

```bash
proxychains wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
sudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
proxychains wget https://developer.download.nvidia.com/compute/cuda/11.2.2/local_installers/cuda-repo-wsl-ubuntu-11-2-local_11.2.2-1_amd64.deb
sudo dpkg -i cuda-repo-wsl-ubuntu-11-2-local_11.2.2-1_amd64.deb
sudo apt-key add /var/cuda-repo-wsl-ubuntu-11-2-local/7fa2af80.pub
sudo proxychains apt-get update
sudo proxychains apt-get -y install cuda
```



**test cuda**

```bash
conda activate pytorch
ipython
import torch
torch.cuda.is_available()
```





## conda

from https://docs.conda.io/en/latest/miniconda.html

download https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

and install with `./Miniconda3-latest-Linux-x86_64.sh -p $HOME/miniconda3`



## pycaret

```bash
conda create --name pycaret python=3.7
conda activate pycaret

proxychains pip install pycaret shap
proxychains conda install -c conda-forge  nb_conda jupyter_contrib_nbextensions fire pyfiglet openpyxl
jupyter contrib nbextensions install --user
proxychains conda upgrade nbconvert

```



## pytorch

```bash
proxychains conda create -n pytorch python=3.8
proxychains conda activate pytorch
proxychains conda install -c pytorch pytorch=1.7.1 torchvision
proxychains conda install jupyter
proxychains conda install -c conda-forge jupyter_contrib_nbextensions
```

