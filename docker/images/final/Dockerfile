FROM alpine:3.2

# Set Environment variables
ENV RABBITMQ_HOME=/opt/rabbitmq \
    PLUGINS_DIR=/opt/rabbitmq/plugins \
    ENABLED_PLUGINS_FILE=/opt/rabbitmq/etc/rabbitmq/enabled_plugins \
    RABBITMQ_MNESIA_BASE=/var/lib/rabbitmq

# Install Dependencies
RUN apk add --update curl tar xz bash
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add erlang erlang erlang-mnesia erlang-public-key erlang-crypto erlang-ssl \
    erlang-sasl erlang-asn1 erlang-inets erlang-os-mon erlang-xmerl erlang-eldap \
    erlang-syntax-tools --update-cache --allow-untrusted

# Download and install RabittMQ
WORKDIR /opt
RUN curl -Lv -o /opt/rabbitmq-server-generic-unix-3.6.0.tar.xz \
    https://github.com/rabbitmq/rabbitmq-server/releases/download/rabbitmq_v3_6_0/rabbitmq-server-generic-unix-3.6.0.tar.xz && \
    tar -xvf /opt/rabbitmq-server-generic-unix-3.6.0.tar.xz && \
    rm -f /opt/rabbitmq-server-generic-unix-3.6.0.tar.xz
RUN touch /opt/rabbitmq_server-3.6.0/etc/rabbitmq/enabled_plugins && \
    /opt/rabbitmq_server-3.6.0/sbin/rabbitmq-plugins enable --offline rabbitmq_management
RUN apk del --purge tar xz && rm -Rf /var/cache/apk/*
RUN mv /opt/rabbitmq_server-3.6.0 /opt/rabbitmq

# Set Configurations
COPY rabbitmq.config /opt/rabbitmq/etc/rabbitmq/

# Set SSL certs
COPY cert.pem /ssl/server/
COPY key.pem /ssl/server/
COPY cacert.pem /ssl/ca/

# Set Erlang Cookie
Copy .erlang.cookie /var/lib/rabbitmq/
RUN chmod 600 /var/lib/rabbitmq/.erlang.cookie

# Set Plugins
RUN /opt/rabbitmq/sbin/rabbitmq-plugins enable --offline rabbitmq_management
RUN /opt/rabbitmq/sbin/rabbitmq-plugins enable rabbitmq_mqtt
RUN /opt/rabbitmq/sbin/rabbitmq-plugins enable rabbitmq_auth_mechanism_ssl

# Ports and Entrypoint
EXPOSE 5671 5672 15671 15672 1883 8883
CMD ["/opt/rabbitmq/sbin/rabbitmq-server"]