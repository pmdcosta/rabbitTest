#!/usr/bin/env python
import pika


# Whenever a message is received, this function is called
def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)


# Setup connection
credentials = pika.PlainCredentials('pmdcosta', 'password')
ssl_option = {'certfile': '/home/pmdcosta/PycharmProjects/rabbit/ssl/client/cert.pem',
              'keyfile': '/home/pmdcosta/PycharmProjects/rabbit/ssl/client/key.pem'}

connection = pika.BlockingConnection(
    pika.ConnectionParameters(host='172.17.0.2', port=5671, credentials=credentials, ssl=True, ssl_options=ssl_option))
channel = connection.channel()

# Create Exchange
channel.exchange_declare(exchange='gateway', type='topic')

# Create a temporary queue with random name
result = channel.queue_declare(exclusive=True)
queue_name = result.method.queue

# Bind the queue to the exchange
channel.queue_bind(exchange='gateway', queue=queue_name, routing_key="*.reports")

# Receive message from queue and execute call callback function
channel.basic_consume(callback, queue=queue_name, no_ack=True)

# Never ending loop waiting for messages
print(' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()
