#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    echo "Usage: server_ssl.sh CN CA_ROOT"
    exit
fi

CN=$1
mkdir ${CN} && cd ${CN}

CERT_ROOT=$PWD
CA_ROOT=../$2

# Create client key and cert
openssl genrsa -out key.pem 2048
openssl req -new -key key.pem -out req.pem -outform PEM -subj "/C=PT/ST=Coimbra/L=Coimbra/O=Whitesmith/OU=Qold/CN=${CN}" -nodes

# Sign the cert
(cd ${CA_ROOT} && openssl ca -config openssl.cnf -in ${CERT_ROOT}/req.pem -out ${CERT_ROOT}/cert.pem -notext -batch -extensions server_ca_extensions)
rm req.pem

# Copy CACert
cp ${CA_ROOT}/cacert.pem .
