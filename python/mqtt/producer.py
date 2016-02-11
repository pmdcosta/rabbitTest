#!/usr/bin/env python
import paho.mqtt.client as mqtt


def on_connect(client, userdata, flags, rc):
    print("Connected with result code " + str(rc))


client = mqtt.Client()

client.username_pw_set("pmdcosta", password="password")
client.tls_set(ca_certs='/home/pmdcosta/PycharmProjects/rabbit/ssl/ca/cacert.pem',
               certfile='/home/pmdcosta/PycharmProjects/rabbit/ssl/client/cert.pem',
               keyfile='/home/pmdcosta/PycharmProjects/rabbit/ssl/client/key.pem')
client.on_connect = on_connect

client.connect("server", 8883, 60)
client.publish("reports", payload='{id:"1234", temp:"20"}', qos=1, retain=False)
