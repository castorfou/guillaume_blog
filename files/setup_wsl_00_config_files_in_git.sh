echo "config files in git v4"
sudo mkdir -p /.cfg
sudo chown $USER:users /.cfg
git init --bare /.cfg
config='/usr/bin/git --git-dir=/.cfg/ --work-tree=/'
$config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=/.cfg/ --work-tree=/'" >> $HOME/.bash_aliases

echo 'config status' >> ~/.bashrc

cd
$config config --global user.email "guillaume.ramelet@michelin.com"
$config config --global user.name "guillaume"
$config remote add origin git@gitlab.michelin.com:janus/dotfiles.git
$config fetch
cd
$config add .bashrc
$config commit -m 'init with .bashrc'

$config branch GR_WSL2_ubuntu22.04
$config checkout GR_WSL2_ubuntu22.04
$config push --set-upstream origin GR_WSL2_ubuntu22.04

$config add .profile
$config commit -m 'start wsl-vpnkit'

$config add .bash_aliases
$config commit -m 'alias config'

$config add .gitconfig
$config commit -m 'id for git'

$config add .ssh/id_rsa.pub
$config commit -m 'public certificate'

$config add .ssh/known_hosts
$config commit -m 'gitlab.michelin.com as known host'

$config add /etc/ssl/openssl.cnf
$config commit -m 'due to bug https://bugs.launchpad.net/ubuntu/+source/openssl/+bug/1963834/comments/7'

$config add /etc/apt/apt.conf.d/90globalprotectconf
$config add /etc/apt/sources.list
$config commit -m 'config apt with artifactory'

$config add /etc/wsl.conf
$config commit -m 'wsl.conf'


$config push