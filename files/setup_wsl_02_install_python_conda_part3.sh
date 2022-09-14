echo "configure SSL cert v1"

export SSL_CERT_FILE=`python -c 'import certifi;print(certifi.where())'`

tee -a ~/.bashrc << EOF
export SSL_CERT_FILE=$SSL_CERT_FILE
EOF

export TMPDIR=`mktemp -d`
git clone git@gitlab.michelin.com:DEV/bib-certificates.git $TMPDIR
cd $TMPDIR
cat *trust-ca.pem >> $SSL_CERT_FILE

if [ -e "/.cfg" ]; then
		config='/usr/bin/git --git-dir=/.cfg/ --work-tree=/'
		$config add ~/.bashrc
		$config commit -m'export certificates for commandline'
		$config push		
fi