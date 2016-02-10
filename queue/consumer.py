#!/usr/bin/env python
import pika


# Subscribe a function to a queue, whenever a message is received, this function is called
def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)
    ch.basic_ack(delivery_tag=method.delivery_tag)


# Settup connection
credentials = pika.PlainCredentials('pmdcosta', 'password')
connection = pika.BlockingConnection(pika.ConnectionParameters('172.17.0.2', credentials=credentials))
channel = connection.channel()

# Create queue hello
channel.queue_declare(queue='hello', durable=True)

# Receive message from queue and execute call callback function, waits for ack before getting new one
channel.basic_qos(prefetch_count=1)
channel.basic_consume(callback, queue='hello')

# Never ending loop waiting for messages
print(' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()
