#!/bin/bash

echo "================== Looking for Servers to Cluster with ================="
hosts=$(nslookup frontend | grep 172.16 | awk -F ' ' '{print $3}') && \
hosts=$(echo $hosts | tr ' ' ,) && \
sed -i -e "s/cluster_nodes, {\[\]/cluster_nodes, {\[$hosts\]/g" /opt/rabbitmq/etc/rabbitmq/rabbit.config

echo "==================== Starting RabbitMQ ==================="
/opt/rabbitmq/sbin/rabbitmq-server