FROM alpine:3.2
MAINTAINER Pedro Costa

# Install dependencies and basic packages
RUN apk add --update curl tar bash nano openssl-dev ca-certificates

# Set ca configurations
RUN mkdir -p /ssl/ca
COPY openssl.cnf /ssl/ca

# Create entrypoint
COPY create-ca.sh /ssl/ca
RUN chmod +x /ssl/ca/create-ca.sh

# Entrypoint
CMD ["/ssl/ca/create-ca.sh"]
