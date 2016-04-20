# RabbitMQ server credentials
kubectl create secret generic rabbitmq-ssl --from-file=server.pem --from-file=server-key.pem

# Cookie for RabbitMQ clustering authentication
kubectl create -f cookie.yaml
