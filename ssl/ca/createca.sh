# Create Certificate Authority
openssl req -x509 -config openssl.cnf -newkey rsa:2048 -out cacert.pem -outform PEM -subj "/C=PT/ST=Coimbra/L=Coimbra/O=Whitesmith/OU=Qold/CN=qold.co" -nodes
