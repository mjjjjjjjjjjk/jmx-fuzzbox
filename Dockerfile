#
# fuzzbox provides cjmx (like jconsole) and jmx_examples and other utilities.
#
FROM ubuntu:17.10
MAINTAINER Mike Kurtis "mkurtis@mesosphere.com"

# Get Ubuntu packages (including Java);
# 	openjdk-8-jre \
RUN apt-get update && apt-get install -y \
	openjdk-8-jdk \
	wget \
	netcat \
	nmap \
	iproute2 \
	zip \
	vim \
	git \
	curl \
	openssl \
	openssh-server \
	openssh-client \
	dnsutils \
	jq \
	unzip 


WORKDIR /root

# grab the jvm-mon stuff;
#RUN mkdir -p /root/jvm-mon \
#    && curl -SL https://github.com/ajermakovics/jvm-mon/releases/download/0.3/jvm-mon-0.3.tar.gz \
#    | tar -xjC /root/jvm-mon 
COPY files files

# Copy in the readme, .ssh;
COPY README.txt .
COPY .ssh .ssh

# Add the ever useful Vish toolbox;
COPY dcos-toolbox dcos-toolbox
#RUN git clone  https://github.com/vishnu2kmohan/dcos-toolbox # also works, but meh.

# Copy some scripts in;
COPY scripts scripts
RUN mkdir /run/sshd

# Make port 80 available to the world outside this container
EXPOSE 22
EXPOSE 80
EXPOSE 6666-9999


# Get CJMX the command line jconsole utility;
WORKDIR /root/cjmx
RUN curl -O http://search.maven.org/remotecontent?filepath=com/github/cjmx/cjmx_2.12/2.7.0/cjmx_2.12-2.7.0-app.jar


# Get/run the jmx_examples
WORKDIR /root/jmx_examples
RUN wget https://docs.oracle.com/javase/tutorial/jmx/examples/jmx_examples.zip
RUN unzip ./jmx_examples.zip
RUN export CLASSPATH=.:./com:./com/example:./com/example/Main.class:./com/example/Main.java
RUN javac com/example/*.java
RUN export CLASSPATH=.:/root/com/example/Main.class
CMD ["ip", "a", "|", "grep", "inet"]
CMD ["java", "-Dcom.sun.management.jmxremote.rmi.port=9999", "-Dcom.sun.management.jmxremote.port=9999",  "-Dcom.sun.management.jmxremote.authenticate=false", "-Dcom.sun.management.jmxremote.ssl=false",  "com.example.Main" ]

