#!/usr/bin/env python
import pika

# Setup connection
credentials = pika.PlainCredentials('pmdcosta', 'password')
connection = pika.BlockingConnection(pika.ConnectionParameters('172.17.0.2', credentials=credentials))
channel = connection.channel()

# Create queue hello
channel.queue_declare(queue='hello', durable=True)

# Publish to default exchange
channel.basic_publish(exchange='', routing_key='hello', body='Hello World!',
                      properties=pika.BasicProperties(delivery_mode=2))

print(" [x] Sent 'Hello World!'")

# Close connection and flush buffers
connection.close()
