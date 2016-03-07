#!/bin/bash

mkdir certs private
chmod 700 private
echo 01 > serial
touch index.txt

openssl req -x509 -config openssl.cnf -newkey rsa:2048 -out cacert.pem -outform PEM -subj "/C=PT/ST=Coimbra/L=Coimbra/O=Whitesmith/OU=Qold/CN=qold_ca" -nodes