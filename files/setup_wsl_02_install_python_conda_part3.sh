echo "configure SSL cert v2"

conda deactivate
pip install -U certifi
export SSL_CERT_FILE=`python -c 'import certifi;print(certifi.where())'`

export TMPDIR=`mktemp -d`
git clone git@gitlab.michelin.com:DEV/bib-certificates.git $TMPDIR
cd $TMPDIR
cat *trust-ca.pem >> $SSL_CERT_FILE

tee -a ~/.bashrc << EOF
export SSL_CERT_FILE=$SSL_CERT_FILE
EOF

if [ -e "/.cfg" ]; then
		config='/usr/bin/git --git-dir=/.cfg/ --work-tree=/'
		$config add ~/.bashrc
		$config commit -m'export certificates for commandline'
		$config push		
fi