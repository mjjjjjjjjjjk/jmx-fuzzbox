

## Summary

JMX-Fuzzbox is a container based set of utilities aimed at performing JMX profiling of DC/OS Marathon on Marathon, which is a Docker container based Java apps.   However JMX-Fuzzbox should be useful for connecting to any container based Java app.  It uses [CJMX](https://github.com/cjmx/cjmx) to provide command line based JMX Client.

## Prerequisites

- DC/OS Cluster
- Access to a Docker Repository.
- A Working DC/OS CLI



## Steps to Build a Container With the Correct Tooling

Build the container using 'docker build';

    docker build -t <your docker repo>/jmx-fuzzbox:<version> <dir>
    
    E.g.;
    
    mkdir -p ~/git/jmx-fuzzbox
    cd ~/git/jmx-fuzzbox
    git pull mjjjjjjjjjjk/jmx-fuzzbox
    docker build -t mkurtis/jmx-fuzzbox:v3 jmx-fuzzbox


In order for an appropriately instrumented Java app to listen for JMX (Java Management Extension) over RMI protocol, the following Java properties must be set;


    ANY_INTERFACE='0.0.0.0'
    DOCKER_HSOT_ETH0_IP=
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



The key issue is that the Java app, in this case user-marathon (which runs inside a Docker container), will need to know the ip address of the host on which it is run.  This can be passed to the Docker container at runtime by way of environment variables.

In this case, use a $JAVA_OPTS_PRE environment variable to obtain IP and PORT just prior to running the 'start' script.  In the user-marathon.JSON file, prepend the following to the "cmd" section;

    "cmd": "LIBPROCESS_PORT=$PORT1 && export JAVA_OPTS=\"$JAVA_OPTS_PRE -Djava.rmi.server.hostname=$HOST -Dcom.sun.management.jmxremote.port=$PORT_JMX -Dcom.sun.management.jmxremote.rmi.port=$PORT_JMX \" && export && ./bin/start ...


The $JAVA_OPTS_PRE contents is defined elsewhere in the user-marathon.JSON File, specifically in the 'env' section;

e.g.; 

    "env": {
    "DCOS_PACKAGE_FRAMEWORK_NAME": "dev-user-marathon",
    "JAVA_OPTS_PRE": "-Dcom.sun.management.jmxremote  -Dcom.sun.management.jmxremote.ssl=false  -Dcom.sun.management.jmxremote.registry.ssl=false  -Dcom.sun.management.jmxremote.authenticate=false  -Dcom.sun.management.jmxremote.local.only=false  -Dcom.sun.management.jmxremote.host=0.0.0.0  -Dcom.sun.management.jmxremote.ssl.config.file=null  -Dcom.sun.management.jmxremote.ssl.enabled.cipher.suites=null  -Dcom.sun.management.jmxremote.ssl.enabled.protocols=null  -Dcom.sun.management.jmxremote.ssl.need.client.auth=false ",
    "JVM_OPTS": "-Xms256m -Xmx4g",
    ...
    
