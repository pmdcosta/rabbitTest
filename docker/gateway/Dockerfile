FROM alpine:3.2
MAINTAINER Pedro Costa

# Install dependencies and basic packages
RUN apk add --update curl tar bash nano openssl-dev ca-certificates

# Install python
RUN apk add --update python python-dev py-pip build-base gcc build-essentials
RUN pip install --upgrade pip

# Set env
ENV GATEWAY_SERVER=rabbitmq \
	GATEWAY_PORT=8883 \
	GATEWAY_VHOST=development \
	GATEWAY_TOPIC=reports \
	GATEWAY_ID=$HOSTNAME \
	GATEWAY_CA=/ssl/ca/cacert.pem \
	GATEWAY_CERT=/ssl/client/cert.pem \
	GATEWAY_KEY=/ssl/client/key.pem

# Add Firmware
RUN mkdir /qold
COPY device_receiver /qold
WORKDIR /qold/

# Install app dependencies
#RUN pip install requirements.txt

# Create entrypoint
ADD start-gateway.sh /usr/bin/
RUN chmod +x /usr/bin/start-gateway.sh

CMD ["/ssl/ca/start-gateway.sh"]