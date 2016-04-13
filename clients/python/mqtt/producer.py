import time
import paho.mqtt.client as mqtt

server = "rabbitmq.qold.co"
port = 8883
vhost = "dev"
topic = "reports"

client_id = "King"

ca_certs = '/home/pmdcosta/Desktop/ssl/ca/ca.pem'
certfile = '/home/pmdcosta/Desktop/ssl/king/client.pem'
keyfile = '/home/pmdcosta/Desktop/ssl/king/client-key.pem'


def on_connect(client, userdata, flags, rc):
    print("Connected with result code " + str(rc) + "\n")


try:
    client = mqtt.Client(client_id=client_id, clean_session=True, userdata=None, protocol="MQTTv31")
    client.tls_set(ca_certs=ca_certs, certfile=certfile, keyfile=keyfile, tls_version=2)

    will_payload = 'Client ' + client_id + ' disconnected!'
    client.will_set(topic, payload=will_payload, qos=1, retain=False)

    client.on_connect = on_connect
    client.connect(server, port, keepalive=60, bind_address="")

    client.loop_start()

    msgNum = int(input("Quantity of test messages: "))

    for i in range(msgNum):
        message = "Message: " + str(i)
        (result, mid) = client.publish(topic, payload=str(message), qos=1, retain=False)
        print(mid)
        time.sleep(0.1)

    client.loop_stop()
    client.disconnect()
except Exception as e:
    print(e)
