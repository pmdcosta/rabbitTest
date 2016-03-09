#!/bin/bash

# Check if SSL certs are present
if [ ! -f /ssl/client/cert.pem ] || [ ! -f /ssl/client/key.pem ]; then
    echo "=============== Creating SSL certificates ================"
    mkdir -p /ssl/client
	cd /ssl/client

	CN=$HOSTNAME
	CERT_ROOT=/ssl/client
	CA_ROOT=/ssl/ca

	# Create client key and cert
	openssl genrsa -out key.pem 2048
	openssl req -new -key key.pem -out req.pem -outform PEM -subj "/C=PT/ST=Coimbra/L=Coimbra/O=Whitesmith/OU=Gateway/CN=${CN}" -nodes

	# Sign the cert
	(cd ${CA_ROOT} && openssl ca -config openssl.cnf -in ${CERT_ROOT}/req.pem -out ${CERT_ROOT}/cert.pem -notext -batch -extensions server_ca_extensions)
	rm req.pem
fi

echo "================== Starting server_producer ================="
/qold/device_receiver python server_producer &

echo "================== Starting device_consumer ================="
/qold/device_receiver python device_consumer