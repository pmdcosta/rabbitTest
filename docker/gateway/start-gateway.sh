#!/bin/bash

# Check if SSL certs are present
if [ ! -f /ssl/$HOSTNAME/cert.pem ] || [ ! -f /ssl/$HOSTNAME/key.pem ]; then
    echo "=============== Creating SSL certificates ================"
    mkdir -p /ssl/$HOSTNAME
	cd /ssl/$HOSTNAME

	CN=$HOSTNAME
	CERT_ROOT=/ssl/$HOSTNAME
	CA_ROOT=/ssl/ca

	# Create client key and cert
	openssl genrsa -out key.pem 2048
	openssl req -new -key key.pem -out req.pem -outform PEM -subj "/C=PT/ST=Coimbra/L=Coimbra/O=Whitesmith/OU=Gateway/CN=${CN}" -nodes

	# Sign the cert
	(cd ${CA_ROOT} && openssl ca -config openssl.cnf -in ${CERT_ROOT}/req.pem -out ${CERT_ROOT}/cert.pem -notext -batch -extensions server_ca_extensions)
	rm req.pem
fi

echo "================== Install Dependencies ====================="
pip install -r /qold/qold-hub-firmware/requirements.txt

echo "================== Starting server_producer ================="
/qold/qold-hub-firmware/src python qold_input.py &

echo "================== Starting device_consumer ================="
/qold/qold-hub-firmware/src python qold_output.py
