echo "install conda v3"
tmp_dir=$(mktemp -d )
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -P $tmp_dir
chmod +x $tmp_dir/Miniconda3-latest-Linux-x86_64.sh
$tmp_dir/Miniconda3-latest-Linux-x86_64.sh -f -b -p ~/miniconda
~/miniconda/bin/conda init
# create a config file
tee ~/.condarc << EOF
ssl_verify: false
shortcuts: false
report_errors: false
EOF

if [ -e "/.cfg" ]; then
		config='/usr/bin/git --git-dir=/.cfg/ --work-tree=/'
		$config add ~/.condarc
		$config commit -m'config for Michelin'
		$config push		
fi