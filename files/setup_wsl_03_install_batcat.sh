echo "install batcat v1"

sudo apt install -y bat

echo "alias cat='batcat'" >> $HOME/.bash_aliases

if [ -e "/.cfg" ]; then
		config='/usr/bin/git --git-dir=/.cfg/ --work-tree=/'
		$config add ~/.bash_aliases
		$config commit -m'bat cat'	
		$config push		
fi

