# RabbitMQ Docker container
docker run -d --hostname rabbit --name rabbitmq -e RABBITMQ_ERLANG_COOKIE='cookie monster' rabbitmq:3
docker run -d --hostname rabbit --name rabbitmq -e RABBITMQ_DEFAULT_USER=pmdcosta -e RABBITMQ_DEFAULT_PASS=password rabbitmq:3-management

# RabbitMQ management
docker run -it --rm --link rabbitmq -e RABBITMQ_ERLANG_COOKIE='cookie monster' rabbitmq:3 bash

# Management Commands
rabbitmqctl list_users
rabbitmqctl list_queues name messages_ready messages_unacknowledged
rabbitmqctl list_exchanges
rabbitmqctl list_bindings



# MQTT image
docker run -d \
    --hostname rabbit --name rabbitmq \
    -v /home/pmdcosta/PycharmProjects/rabbit/ssl/:/ssl \
    -e RABBITMQ_DEFAULT_USER=pmdcosta \
    -e RABBITMQ_DEFAULT_PASS=password \
    -e RABBITMQ_SSL_CERT_FILE=/ssl/server/cert.pem \
    -e RABBITMQ_SSL_KEY_FILE=/ssl/server/key.pem \
    -e RABBITMQ_SSL_CA_FILE=/ssl/ca/cacert.pem \
    rabbitmqtt


