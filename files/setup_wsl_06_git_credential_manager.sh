echo "install git credential manager v1"

tmp_dir=$(mktemp -d )
wget https://github.com/GitCredentialManager/git-credential-manager/releases/download/v2.0.696/gcmcore-linux_amd64.2.0.696.deb -P $tmp_dir
sudo dpkg -i $tmp_dir/gcmcore-linux_amd64.2.0.696.deb
git-credential-manager-core configure

if [ -e "/.cfg" ]; then
		config='/usr/bin/git --git-dir=/.cfg/ --work-tree=/'
		$config add ~/.git_config
		$config commit -m'git credential manager'	
		$config push		
fi

