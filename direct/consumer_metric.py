#!/usr/bin/env python
import pika


# Whenever a message is received, this function is called
def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)


# Setup connection
credentials = pika.PlainCredentials('pmdcosta', 'password')
connection = pika.BlockingConnection(pika.ConnectionParameters(host='172.17.0.2', credentials=credentials))
channel = connection.channel()

# Create Exchange
channel.exchange_declare(exchange='gateway', type='direct')

# Create a temporary queue with random name
result = channel.queue_declare(exclusive=True)
queue_name = result.method.queue

# Bind the queue to the exchange
channel.queue_bind(exchange='gateway', queue=queue_name, routing_key="metric")

# Receive message from queue and execute call callback function
channel.basic_consume(callback, queue=queue_name, no_ack=True)

# Never ending loop waiting for messages
print(' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()
