#!/bin/bash

echo "========================== Set earlang-cookie =========================="
echo $EARLANG_COOKIE > /root/.earlang.cookie

echo "========================== Enable pluggins ============================="
/opt/rabbitmq/sbin/rabbitmq-plugins enable --offline rabbitmq_management
/opt/rabbitmq/sbin/rabbitmq-plugins enable --offline rabbitmq_mqtt
/opt/rabbitmq/sbin/rabbitmq-plugins enable --offline rabbitmq_auth_mechanism_ssl

echo "========================== Print Config ================================"
cat /opt/rabbitmq/etc/rabbitmq/rabbitmq.config

echo "========================== Starting RabbitMQ ==========================="
/opt/rabbitmq/sbin/rabbitmq-server
