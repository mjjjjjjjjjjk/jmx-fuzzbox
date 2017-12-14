#!/bin/bash

# How to run cjmx;               

echo "Enter the OTHER host's IP address"
read otherip

ssh -L 9999:localhost:9999 -i ~/.ssh/id_rsa_fuzzbox otherip


cd /root/cjmx
JAVA_HOME='/usr/lib/jvm/java-8-openjdk-amd64'
#java -cp $JAVA_HOME/lib/tools.jar:cjmx_2.12-2.7.0-app.jar cjmx.Main [PID]
java -cp $JAVA_HOME/lib/tools.jar:cjmx_2.12-2.7.0-app.jar cjmx.Main 

