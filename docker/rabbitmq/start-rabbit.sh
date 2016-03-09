#!/bin/bash

# Check if SSL certs are present
if [ ! -f /ssl/server/cert.pem ] || [ ! -f /ssl/server/key.pem ]; then
    echo "=============== Creating SSL certificates ================"
    mkdir -p /ssl/server
	cd /ssl/server

	CN=$HOSTNAME
	CERT_ROOT=/ssl/server
	CA_ROOT=/ssl/ca

	# Create server key and cert
	openssl genrsa -out key.pem 2048
	openssl req -new -key key.pem -out req.pem -outform PEM -subj "/C=PT/ST=Coimbra/L=Coimbra/O=Whitesmith/OU=Qold/CN=${CN}" -nodes

	# Sign the cert
	(cd ${CA_ROOT} && openssl ca -config openssl.cnf -in ${CERT_ROOT}/req.pem -out ${CERT_ROOT}/cert.pem -notext -batch -extensions server_ca_extensions)
	rm req.pem
fi

echo "================== Starting Consul Client ================="
/bin/consul agent -join consul -config-dir=/config/client &

echo "==================== Starting RabbitMQ ==================="
/opt/rabbitmq/sbin/rabbitmq-server