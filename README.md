

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


