echo "configure base v5"
conda install -y mamba -n base -c conda-forge
mamba init
mamba install -y nb_conda_kernels
mamba install -y -c conda-forge jupyterlab jupyterlab-git
tee -a ~/.bashrc << EOF
export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
EOF

tee -a ~/.bashrc << EOF
function conda() {
mamba "$@";
}
export -f conda
EOF

sudo apt install -y nodejs npm

# to launch browser after starting jupyter
jupyter notebook --generate-config
echo 'c.NotebookApp.use_redirect_file = False' >> ~/.jupyter/jupyter_notebook_config.py
tee -a ~/.bashrc << EOF
export PATH="/mnt/c/Program Files/Google/Chrome/Application:$PATH"
export BROWSER='chrome.exe'
EOF


if [ -e "/.cfg" ]; then
		config='/usr/bin/git --git-dir=/.cfg/ --work-tree=/'
		$config add ~/.bashrc
		$config commit -m'export certificates for conda, and conda as mamba'
		$config add ~/.jupyter/jupyter_notebook_config.py
		$config commit -m'launch browser with jupyter'
		$config push		
		
fi

