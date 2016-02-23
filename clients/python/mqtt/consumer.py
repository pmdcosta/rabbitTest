#!/usr/bin/env python
import paho.mqtt.client as mqtt


def on_connect(client, userdata, flags, rc):
    print("Connected with result code " + str(rc))


def on_message(client, userdata, msg):
    print(msg.topic + " " + str(msg.payload))


client = mqtt.Client()

client.username_pw_set("pmdcosta", password="password")
client.on_connect = on_connect
client.on_message = on_message

client.connect("server", 1883, 60)
client.subscribe("reports")
client.loop_forever()