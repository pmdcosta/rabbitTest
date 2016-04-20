#!/bin/bash

echo "========================== Set earlang-cookie =========================="
echo $EARLANG_COOKIE > /root/.earlang.cookie

echo "========================== Enable pluggins ============================="
/opt/rabbitmq/sbin/rabbitmq-plugins enable --offline rabbitmq_management
/opt/rabbitmq/sbin/rabbitmq-plugins enable --offline rabbitmq_mqtt
/opt/rabbitmq/sbin/rabbitmq-plugins enable --offline rabbitmq_auth_mechanism_ssl

echo "========================== Set users and permissions ==================="
/opt/rabbitmq/sbin/rabbitmqctl add_user cluster
/opt/rabbitmq/sbin/rabbitmqctl add_user gateway
/opt/rabbitmq/sbin/rabbitmqctl add_vhost development
/opt/rabbitmq/sbin/rabbitmqctl set_permissions -p development qold '.*' '.*' '.*'
/opt/rabbitmq/sbin/rabbitmqctl set_permissions -p development cluster '' '.*' '.*'
/opt/rabbitmq/sbin/rabbitmqctl set_permissions -p development gateway '' '^gateway$' ''
/opt/rabbitmq/sbin/rabbitmqctl add_vhost production
/opt/rabbitmq/sbin/rabbitmqctl set_permissions -p production qold '.*' '.*' '.*'
/opt/rabbitmq/sbin/rabbitmqctl set_permissions -p production cluster '' '.*' '.*'
/opt/rabbitmq/sbin/rabbitmqctl set_permissions -p production gateway '' '^gateway$' ''

echo "========================== Print Config ================================"
cat /opt/rabbitmq/etc/rabbitmq/rabbitmq.config

echo "========================== Starting RabbitMQ ==========================="
/opt/rabbitmq/sbin/rabbitmq-server
