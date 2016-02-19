#!/usr/bin/env python
import pika
from pika.credentials import ExternalCredentials
import time


# Setup connection
ssl_option = {'certfile': '/home/pmdcosta/DockerProjects/rabbitmq-test/ssl/pmdcosta/cert.pem',
              'keyfile': '/home/pmdcosta/DockerProjects/rabbitmq-test/ssl/pmdcosta/key.pem'}

connection = pika.BlockingConnection(
    pika.ConnectionParameters(host='server', port=5671, credentials=ExternalCredentials(), ssl=True,
                              ssl_options=ssl_option))
channel = connection.channel()

# Create a temporary queue with random name
result = channel.queue_declare(queue='consumer1', durable=True)
queue_name = result.method.queue

# Bind the queue to the exchange
channel.queue_bind(exchange='amq.topic', queue=queue_name, routing_key="reports")

i = 0
start = int(time.time())
while channel.basic_get(queue=queue_name, no_ack=False)[0] is not None:
    i += 1
end = int(time.time())

print('Took', (end - start), 'seconds to receive', i, 'messages')