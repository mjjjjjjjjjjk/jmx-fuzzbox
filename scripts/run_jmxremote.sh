#!/bin/bash


if [ -z $DOCKER_HOST_ETH0_IP ];then
        echo "\$DOCKER_HOST_ETH0_IP not defined - exiting (try again with that env var passed to 'docker run')"
        exit 5
fi


ANY_INTERFACE='0.0.0.0'

cd /root/jmx_examples

java \
        -Dcom.sun.management.jmxremote \
        -Dcom.sun.management.jmxremote.port=9999 \
        -Dcom.sun.management.jmxremote.rmi.port=9999 \
        -Dcom.sun.management.jmxremote.ssl=false \
        -Dcom.sun.management.jmxremote.registry.ssl=false \
        -Dcom.sun.management.jmxremote.authenticate=false \
        -Dcom.sun.management.jmxremote.local.only=false \
        -Dcom.sun.management.jmxremote.host=${ANY_INTERFACE} \
        -Dcom.sun.management.jmxremote.ssl.config.file=null \
        -Dcom.sun.management.jmxremote.ssl.enabled.cipher.suites=null \
        -Dcom.sun.management.jmxremote.ssl.enabled.protocols=null \
        -Dcom.sun.management.jmxremote.ssl.need.client.auth=false \
        -Djava.rmi.server.hostname=${DOCKER_HOST_ETH0_IP} \
        com.example.Main



