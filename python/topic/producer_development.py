#!/usr/bin/env python
import pika

# Setup connection
credentials = pika.PlainCredentials('pmdcosta', 'password')

ssl_option = {'certfile': '/home/pmdcosta/PycharmProjects/rabbit/ssl/client/cert.pem',
              'keyfile': '/home/pmdcosta/PycharmProjects/rabbit/ssl/client/key.pem'}

connection = pika.BlockingConnection(
    pika.ConnectionParameters(host='172.17.0.2', port=5671, credentials=credentials, ssl=True, ssl_options=ssl_option))
channel = connection.channel()

# Create Exchange
channel.exchange_declare(exchange='gateway', type='topic')

# Publish report to reports exchange
message = '{id:"1234", temperature:"2", t:"123456789"}'
channel.basic_publish(exchange='gateway', routing_key='development.reports', body=message)
print(" [x] Sent %r" % message)

# Publish metric to reports exchange
message = '{id:"1234", battery:"20%", cpu:"30%", t:"123456789"}'
channel.basic_publish(exchange='gateway', routing_key='development.metrics', body=message)
print(" [x] Sent %r" % message)

# Close connection and flush buffers
connection.close()
