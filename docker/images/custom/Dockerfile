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
COPY ssl.config /opt/rabbitmq/etc/rabbitmq/
COPY standard.config /opt/rabbitmq/etc/rabbitmq/

# Set Docker Entrypoint
COPY entrypoint.sh /usr/bin/entrypoint
RUN chmod a+x /usr/bin/entrypoint

# Ports and Entrypoint
EXPOSE 5671/tcp 5672/tcp 15672/tcp 15671/tcp
CMD ["/usr/bin/entrypoint"]