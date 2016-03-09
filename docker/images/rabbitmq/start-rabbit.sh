#!/bin/bash

# Set Hostname
echo "====================== Set NodeName ======================"
GROUP=docker_rabbit_
NAME=
COUNTER=1

while [ -z "$NAME" ]; do
	TEMP=$GROUP$COUNTER
	if [ 'rabbit' == "$(nslookup $TEMP | grep ' rabbit' | awk '{print$4}')" ]; then
		NAME=TEMP
		HOSTNAME=$TEMP
	fi
	let "COUNTER++"
done

echo "$RABBITMQ_NODENAME"


# Get Rabbit Name
#NODE=$(nslookup rabbit | grep .docker_qold | awk '{print$4}' | cut -d'.' -f 1)
#sed -i "/cluster_nodes/ c\    { cluster_nodes, {[ docker_rabbit_1 ], disc }}" /opt/rabbitmq/etc/rabbitmq/rabbitmq.config


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

# Add hosts to clustering config
#declare -a node_array=($(awk '/rabbit/ && /docker_qold/ {print $2}' /etc/hosts | cut -d'.' -f 1 | awk '{print "rabbit@"$1}')); nodes=$(echo ${node_array[@]} | tr ' ' , )
#sed -i "/cluster_nodes/ c\    { cluster_nodes, {[ $nodes ], disc }}" /opt/rabbitmq/etc/rabbitmq/rabbitmq.config

# Print configs
echo "================= RabbitMQ Configuration ================="
cat /opt/rabbitmq/etc/rabbitmq/rabbitmq.config

# Start RabbitMQ
echo "==================== Starting RabbitMQ ==================="
/opt/rabbitmq/sbin/rabbitmq-server
