#!/usr/bin/env python
import os
import paho.mqtt.client as mqtt

messages = int(os.environ.get('PROD_MESSAGES'))
server = os.environ.get('PROD_SERVER')


def on_connect(client, userdata, flags, rc):
    print("Connected with result code " + str(rc))


client = mqtt.Client()
client.tls_set(ca_certs='/ssl/cacert.pem', certfile='/ssl/cert.pem', keyfile='/ssl/key.pem')
client.on_connect = on_connect
client.connect(server, 8883, 60)

for i in range(messages):
    client.publish("reports", payload='{id:"1234", temp:"20"}', qos=1, retain=False)
    client.loop(10, 20)