/opt/rabbitmq/sbin/rabbitmq-server -detached
/opt/rabbitmq/sbin/rabbitmqctl stop_app
/opt/rabbitmq/sbin/rabbitmqctl join_cluster rabbit@rabbit_1
/opt/rabbitmq/sbin/rabbitmqctl start_app
/opt/rabbitmq/sbin/rabbitmqctl stop
/opt/rabbitmq/sbin/rabbitmq-server