FROM alpine:3.2
MAINTAINER Pedro Costa

# Install dependencies and basic packages
RUN apk add --update curl tar bash nano openssl-dev ca-certificates

# Define Consul env
ENV CONSUL_VERSION 0.6.3
ENV CONSUL_SHA256 b0532c61fec4a4f6d130c893fd8954ec007a6ad93effbe283a39224ed237e250
ENV GLIBC_VERSION "2.23-r1"
ENV GOMAXPROCS 10

# Install Consul
RUN curl -Ls https://github.com/andyshinn/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk > /tmp/glibc-${GLIBC_VERSION}.apk && \
    apk add --allow-untrusted /tmp/glibc-${GLIBC_VERSION}.apk && \
    rm -rf /tmp/glibc-${GLIBC_VERSION}.apk /var/cache/apk/*
ADD https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip /tmp/consul.zip
RUN echo "${CONSUL_SHA256}  /tmp/consul.zip" > /tmp/consul.sha256 \
  && sha256sum -c /tmp/consul.sha256 \
  && cd /bin \
  && unzip /tmp/consul.zip \
  && chmod +x /bin/consul \
  && rm /tmp/consul.zip

# Set Consul configurations
RUN mkdir -p /config/server
RUN mkdir -p /config/client
ADD server.json /config/server
ADD client.json /config/client

# Ports and Entrypoint
#EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 8600 8600/udp
CMD ["/bin/consul", "agent", "-config-file=/config/server/server.json"]
