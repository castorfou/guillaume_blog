echo "configure SSL cert v1"

export SSL_CERT=`python -c 'import certifi;print(certifi.where())'`
echo $SSL_CERT

tee -a ~/.bashrc2 << EOF
export REQUESTS_CA_BUNDLE=$SSL_CERT
EOF

#if [ -e "/.cfg" ]; then
#		config='/usr/bin/git --git-dir=/.cfg/ --work-tree=/'
#		$config add ~/.bashrc
#		$config commit -m'export certificates for commandline'
#		$config push		
#fi

