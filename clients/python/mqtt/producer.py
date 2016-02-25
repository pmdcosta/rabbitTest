import time
import paho.mqtt.client as mqtt

server = "rabbitmq_1"
port = 8883
vhost = "development"
topic = "reports"

client_id = "pmdcosta"

ca_certs = '/home/pmdcosta/DockerProjects/rabbitmq/ssl/ca/cacert.pem'
certfile = '/home/pmdcosta/DockerProjects/rabbitmq/ssl/clients/pmdcosta/cert.pem'
keyfile = '/home/pmdcosta/DockerProjects/rabbitmq/ssl/clients/pmdcosta/key.pem'


def on_connect(client, userdata, flags, rc):
    print("Connected with result code " + str(rc) + "\n")


try:
    client = mqtt.Client(client_id=client_id, clean_session=True, userdata=None, protocol="MQTTv31")
    client.tls_set(ca_certs=ca_certs, certfile=certfile, keyfile=keyfile)

    will_payload = 'Client ' + client_id + ' disconnected!'
    client.will_set(topic, payload=will_payload, qos=1, retain=False)

    client.on_connect = on_connect
    client.connect(server, port, keepalive=60, bind_address="")

    client.loop_start()

    msgNum = int(input("Quantity of test messages: "))

    for i in range(msgNum):
        message = input('Message: ')
        (result, mid) = client.publish(topic, payload=message, qos=1, retain=False)
        print(result)
        print(mid)
        time.sleep(1)

    client.loop_stop()
    client.disconnect()
except Exception as e:
    print(e)
