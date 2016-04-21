echo "========================== Set users and permissions ==================="
/opt/rabbitmq/sbin/rabbitmqctl add_user cluster ""
/opt/rabbitmq/sbin/rabbitmqctl add_user gateway ""
/opt/rabbitmq/sbin/rabbitmqctl add_vhost development
/opt/rabbitmq/sbin/rabbitmqctl set_permissions -p development qold ".*" ".*" ".*"
/opt/rabbitmq/sbin/rabbitmqctl set_permissions -p development cluster ".*" ".*" ".*"
/opt/rabbitmq/sbin/rabbitmqctl set_permissions -p development gateway "^(gateway|reports|disconnects)$" "^(gateway|reports|disconnects)$" ""
/opt/rabbitmq/sbin/rabbitmqctl add_vhost production
/opt/rabbitmq/sbin/rabbitmqctl set_permissions -p production qold ".*" ".*" ".*"
/opt/rabbitmq/sbin/rabbitmqctl set_permissions -p production cluster ".*" ".*" ".*"
/opt/rabbitmq/sbin/rabbitmqctl set_permissions -p production gateway "^(gateway|reports|disconnects)$" "^(gateway|reports|disconnects)$" ""
