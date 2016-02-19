#!/usr/bin/env python
from concurrent.futures import ThreadPoolExecutor
import paho.mqtt.client as mqtt
from time import sleep

producers = 200
threads = 200
load = 10000
executor = ThreadPoolExecutor(max_workers=threads)


def on_connect(client, userdata, flags, rc):
    print("Connected with result code " + str(rc))


def produce():
    client = mqtt.Client()

    client.tls_set(ca_certs='/home/pmdcosta/DockerProjects/rabbitmq-test/ssl/ca/cacert.pem',
                   certfile='/home/pmdcosta/DockerProjects/rabbitmq-test/ssl/pmdcosta/cert.pem',
                   keyfile='/home/pmdcosta/DockerProjects/rabbitmq-test/ssl/pmdcosta/key.pem')

    client.on_connect = on_connect

    client.connect("server", 8883, 60)

    try:
        for x in range(load):
            err = client.publish("reports", payload='{id:"1234", temp:"20"}', qos=1, retain=False)[0]
            client.loop(10, 20)
            if err != 0:
                print("Deu Merda")
            sleep(0.05)
    except KeyboardInterrupt:
        return


for i in range(producers):
    a = executor.submit(produce)

try:
    executor.shutdown(wait=True)
except KeyboardInterrupt:
    print("Shutting Down...")
    executor.shutdown(wait=False)

