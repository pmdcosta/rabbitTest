#!/usr/bin/env python
import paho.mqtt.client as mqtt


def on_connect(client, userdata, flags, rc):
    print("Connected with result code " + str(rc))


client = mqtt.Client()

client.tls_set(ca_certs='/home/pmdcosta/PycharmProjects/rabbit/ssl/ca/cacert.pem',
               certfile='/home/pmdcosta/PycharmProjects/rabbit/ssl/pmdcosta/cert.pem',
               keyfile='/home/pmdcosta/PycharmProjects/rabbit/ssl/pmdcosta/key.pem')
client.on_connect = on_connect

client.connect("server", 8883, 60)
client.publish("reports", payload='{id:"1234", temp:"20"}', qos=1, retain=False)
