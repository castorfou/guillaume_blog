echo "configure pip v2"

mkdir -p ~/.config/pip
tee ~/.config/pip/pip.conf << EOF
[global]
timeout = 1000
index-url = https://pypi.org/simple/
trusted-host = download.pytorch.org
               pypi.python.org
               files.pythonhosted.org
               pypi.org
               artifactory.michelin.com
extra-index-url= https://artifactory.michelin.com/api/pypi/pypi/simple
EOF

if [ -e "/.cfg" ]; then
		config='/usr/bin/git --git-dir=/.cfg/ --work-tree=/'
		$config add ~/.config/pip/pip.conf
		$config commit -m'config artifactory'
		$config push		
fi
