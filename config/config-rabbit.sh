echo "========================== Set users and permissions ==================="
/opt/rabbitmq/sbin/rabbitmqctl add_user cluster ""
/opt/rabbitmq/sbin/rabbitmqctl add_user gateway ""

/opt/rabbitmq/sbin/rabbitmqctl add_vhost qold
/opt/rabbitmq/sbin/rabbitmqctl set_permissions -p qold qold ".*" ".*" ".*"
/opt/rabbitmq/sbin/rabbitmqctl set_permissions -p qold cluster ".*" ".*" ".*"
/opt/rabbitmq/sbin/rabbitmqctl set_permissions -p qold gateway "^(gateway|reports|disconnects|mqtt.*)$" "^(gateway|reports|disconnects|mqtt.*)$" "^(mqtt.*)$"
