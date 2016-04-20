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
/opt/rabbitmq/sbin/rabbitmqctl add_vhost dev
/opt/rabbitmq/sbin/rabbitmqctl set_permissions -p dev qold '.*' '.*' '.*'
/opt/rabbitmq/sbin/rabbitmqctl set_permissions -p dev cluster '' '.*' '.*'
/opt/rabbitmq/sbin/rabbitmqctl set_permissions -p dev gateway '' '^(gateway)$' ''
/opt/rabbitmq/sbin/rabbitmqctl add_vhost prod
/opt/rabbitmq/sbin/rabbitmqctl set_permissions -p prod qold '.*' '.*' '.*'
/opt/rabbitmq/sbin/rabbitmqctl set_permissions -p prod cluster '' '.*' '.*'
/opt/rabbitmq/sbin/rabbitmqctl set_permissions -p prod gateway '' '^(gateway)$' ''


echo "========================== Print Config ================================"
cat /opt/rabbitmq/etc/rabbitmq/rabbitmq.config


echo "========================== Starting RabbitMQ ==========================="
/opt/rabbitmq/sbin/rabbitmq-server
