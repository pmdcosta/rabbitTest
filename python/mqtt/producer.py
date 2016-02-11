#!/usr/bin/env python
import paho.mqtt.client as mqtt


def on_connect(client, userdata, flags, rc):
    print("Connected with result code " + str(rc))


client = mqtt.Client()

client.username_pw_set("pmdcosta", password="password")
client.on_connect = on_connect

client.connect("172.17.0.2", 1883, 60)
client.publish("reports", payload='{id:"1234", temp:"20"}', qos=1, retain=False)
