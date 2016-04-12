#!/bin/bash

echo "=========================== Set Nodename ==============================="
echo $(hostname -i) > /etc/hostname
hostname -F /etc/hostname
export RABBITMQ_USE_LONGNAME=true
export RABBITMQ_NODENAME=rabbit@$HOSTNAME

echo "========================== Set earlang-cookie =========================="
echo $EARLANG_COOKIE > /root/.earlang.cookie


echo "========================== Enable pluggins ============================="
/opt/rabbitmq/sbin/rabbitmq-plugins enable --offline rabbitmq_management
/opt/rabbitmq/sbin/rabbitmq-plugins enable --offline rabbitmq_mqtt
/opt/rabbitmq/sbin/rabbitmq-plugins enable --offline rabbitmq_auth_mechanism_ssl


echo "================== Looking for Servers to Cluster with ================="
unset hosts
hosts=()
for $IP in $(nslookup rabbitmq | grep 172.16 | awk -F ' ' '{print $3}')
do
	hosts+="rabbit@"$IP
done
hosts=$(echo $hosts | tr ' ' ,)
sed -i -e "s/cluster_nodes, {\[\]/cluster_nodes, {\[$hosts\]/g" /opt/rabbitmq/etc/rabbitmq/rabbitmq.config
cat /opt/rabbitmq/etc/rabbitmq/rabbitmq.config

echo "==================== Starting RabbitMQ ==================="
/opt/rabbitmq/sbin/rabbitmq-server
