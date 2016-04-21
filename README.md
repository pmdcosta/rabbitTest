# RabbitMQ
RabbitMQ Docker images


## Label Nodes
kubectl label nodes <node-name> app=rabbitmq

## Configure
kubectl exec rabbitmq-dev-8q8qs -- /bin/bash config-rabbit.sh
