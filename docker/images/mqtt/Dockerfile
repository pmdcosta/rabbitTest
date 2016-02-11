FROM rabbitmq

RUN rabbitmq-plugins enable --offline rabbitmq_management
RUN rabbitmq-plugins enable rabbitmq_mqtt

COPY docker-entrypoint.sh /
RUN chmod +x docker-entrypoint.sh

EXPOSE 15671 15672 1883
