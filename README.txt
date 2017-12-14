# Fuzzbox, 'cuz, why not?

# README file

# How to run cjmx;               
cd cjmx
JAVA_HOME='/usr/lib/jvm/java-8-openjdk-amd64'
java -cp $JAVA_HOME/lib/tools.jar:cjmx_2.12-2.7.0-app.jar cjmx.Main [PID]




# How to run jmx_example/jmxremote;

cd jmx_examples
java -Dcom.sun.management.jmxremote.rmi.port=9999 -Dcom.sun.management.jmxremote.port=9999 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false com.example.Main

