#!/usr/bin/env python
import pika

# Setup connection
credentials = pika.PlainCredentials('pmdcosta', 'password')
connection = pika.BlockingConnection(pika.ConnectionParameters(host='172.17.0.2', credentials=credentials))
channel = connection.channel()

# Create Exchange
channel.exchange_declare(exchange='gateway', type='topic')

# Publish report to reports exchange
message = '{id:"1234", temperature:"2", t:"123456789"}'
channel.basic_publish(exchange='gateway', routing_key='production.reports', body=message)
print(" [x] Sent %r" % message)

# Publish metric to reports exchange
message = '{id:"1234", battery:"20%", cpu:"30%", t:"123456789"}'
channel.basic_publish(exchange='gateway', routing_key='production.metrics', body=message)
print(" [x] Sent %r" % message)

# Close connection and flush buffers
connection.close()
