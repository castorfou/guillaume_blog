echo "automount secured vbox v2"
sudo apt install -y autofs
mkdir -p ~/vbox
if ! grep -Fxq "vbox" /etc/auto.master
then
sudo tee -a /etc/auto.master << EOF
/home/$USER/vbox            /etc/vbox.autofs        --timeout=30 browse
EOF
fi
if [ ! -e "/etc/vbox.autofs" ]; then
sudo tee /etc/vbox.autofs << EOF
janus   -fstype=drvfs,uid=1000,gid=1000 :Z:
cho     -fstype=drvfs,uid=1000,gid=1000 :Y:
EOF
echo "`whoami` ALL=(ALL) NOPASSWD: /usr/sbin/service" | sudo tee /etc/sudoers.d/`whoami` && sudo chmod 0440 /etc/sudoers.d/`whoami`
fi
sudo service autofs start
if ! grep -Fxq "autofs" ~/.bashrc
then
echo 'sudo /usr/sbin/service autofs start' >> ~/.bashrc
fi
echo

if [ -e "/.cfg" ]; then
		config='/usr/bin/git --git-dir=/.cfg/ --work-tree=/'
		$config add ~/.bashrc
		$config commit -m'start autofs service at boot'
		$config add /etc/auto.master
		$config add /etc/vbox.autofs
		$config commit -m'configure autofs for vbox'
		$config push		
fi
