FROM alpine:3.2
MAINTAINER Pedro Costa

RUN apk add --update bash nano openssl openssl-dev ca-certificates

RUN mkdir -p /ssl/ca

COPY create-ca.sh /ssl/ca
COPY openssl.cnf /ssl/ca
RUN chmod +x /ssl/ca/create-ca.sh

WORKDIR /ssl/ca

CMD ["/ssl/ca/create-ca.sh"]
