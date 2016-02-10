#!/usr/bin/env python
import pika

# Setup connection
credentials = pika.PlainCredentials('pmdcosta', 'password')
connection = pika.BlockingConnection(pika.ConnectionParameters(host='172.17.0.2', credentials=credentials))
channel = connection.channel()

# Create Exchange
channel.exchange_declare(exchange='reports', type='fanout')

# Publish to reports exchange
message = '{id:"1234", temperature:"2", t:"123456789"}'
channel.basic_publish(exchange='reports', routing_key='', body=message)

print(" [x] Sent %r" % message)

# Close connection and flush buffers
connection.close()
