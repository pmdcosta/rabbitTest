kubectl create secret generic rabbitmq-ssl --from-file=./ca-cert.pem --from-file=./rabbit-key.pem --from-file=./rabbit-cert.pem
