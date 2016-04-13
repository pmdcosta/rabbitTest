# RabbitMQ server credentials
kubectl create secret generic rabbitmq-ssl --from-file=~/secrets/rabbitmq/server.pem --from-file=~/secrets/rabbitmq/server-key.pem

# Cookie for RabbitMQ clustering authentication
kubectl create -f ./cookie.yaml
