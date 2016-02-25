import pika
from pika.credentials import ExternalCredentials
import time

server = "rabbitmq_1"
port = 5671
vhost = "/"

exchangeName = "ingestion"
queueName = "consumer_01"
topic = "reports"

ca_certs = '/home/pmdcosta/DockerProjects/rabbitmq/ssl/ca/cacert.pem'
certfile = '/home/pmdcosta/DockerProjects/rabbitmq/ssl/clients/pmdcosta/cert.pem'
keyfile = '/home/pmdcosta/DockerProjects/rabbitmq/ssl/clients/pmdcosta/key.pem'


def onMessage(channel, method, properties, body):
    print("Received: %r" % body)
    channel.basic_ack(delivery_tag=method.delivery_tag)


while True:
	try:
		#connect
		ssl_option = {'certfile': certfile, 'keyfile': keyfile}
		connection = pika.BlockingConnection(
			pika.ConnectionParameters(host=server, port=port, virtual_host=vhost, credentials=ExternalCredentials(), ssl=True, ssl_options=ssl_option, heartbeat_interval = 60))
		channel = connection.channel()

		#declare exchange and queue, bind them and consume messages
		channel.exchange_declare(exchange=exchangeName, exchange_type="topic", auto_delete=False)
		channel.queue_declare(queue=queueName, exclusive=True, auto_delete=False)
		channel.queue_bind(exchange=exchangeName, queue=queueName, routing_key=topic)
		channel.basic_consume(consumer_callback=onMessage, queue=queueName)
		channel.start_consuming()
	except KeyboardInterrupt:
		print("Shutting Down...")
		channel.close()
		connection.close()
		break

	except Exception as e:
		print ("Reconnecting...\nException:\n%s" % e)
		try:
			connection.close()
		except:
			pass
		time.sleep(5)