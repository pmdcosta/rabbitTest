FROM alpine:edge
MAINTAINER Pedro Costa

# Install dependencies and basic packages
RUN apk add --update curl tar bash nano openssl-dev ca-certificates

# Define RabbitMQ env
ENV RABBIT_VERSION=3.6.0 \
    RABBITMQ_HOME=/opt/rabbitmq \
    PLUGINS_DIR=/opt/rabbitmq/plugins \
    ENABLED_PLUGINS_FILE=/opt/rabbitmq/etc/rabbitmq/enabled_plugins \
    RABBITMQ_MNESIA_BASE=/data/mnesia \
    RABBITMQ_LOGS=- RABBITMQ_SASL_LOGS=-

# Install RabbitMQ dependencies
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk add erlang erlang erlang-mnesia erlang-public-key erlang-crypto erlang-ssl \
    erlang-sasl erlang-asn1 erlang-inets erlang-os-mon erlang-xmerl erlang-eldap \
    erlang-syntax-tools --update-cache --allow-untrusted

# Install RabbitMQ
WORKDIR /opt/
RUN curl -Lv -o /opt/rabbitmq-server-generic-unix-${RABBIT_VERSION}.tar.xz https://github.com/rabbitmq/rabbitmq-server/releases/download/rabbitmq_v3_6_0/rabbitmq-server-generic-unix-${RABBIT_VERSION}.tar.xz && \
    unxz /opt/rabbitmq-server-generic-unix-${RABBIT_VERSION}.tar.xz && \
    tar -xf /opt/rabbitmq-server-generic-unix-${RABBIT_VERSION}.tar && \
    rm -f /opt/rabbitmq-server-generic-unix-${RABBIT_VERSION}.tar && \
    touch /opt/rabbitmq_server-${RABBIT_VERSION}/etc/rabbitmq/enabled_plugins && \
    apk del --purge tar && \
    rm -Rf /var/cache/apk/* && \
    mv /opt/rabbitmq_server-${RABBIT_VERSION} /opt/rabbitmq

# Set RabbitMQ configurations
ADD rabbitmq.config /opt/rabbitmq/etc/rabbitmq/

# Create entrypoint
ADD start-rabbit.sh /usr/bin/
RUN chmod +x /usr/bin/start-rabbit.sh

# Entrypoint
CMD ["start-rabbit.sh"]
