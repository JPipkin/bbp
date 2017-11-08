FROM library/ubuntu
RUN apt-get update && \
    apt-get -y install wget && \
    apt-get -y install xz-utils && \
    cd ~ && \
    wget https://developer.salesforce.com/media/salesforce-cli/sfdx-linux-amd64.tar.xz -O sfdx.tar.xz && \
    apt-get update && \
    tar -xvJf ~/sfdx.tar.xz && \
    cd sfdx && \
    ./install && \
    apt-get -y install git && \
    sfdx force --help;
    
#Now that DX is installed and ready to go, need to install Java (eww), 
#because things like running jasmine and mocha unit tests depend on Java.
# This is in accordance to : https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-ubuntu-16-04
RUN apt-get install -y openjdk-8-jdk && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;
	
# Fix certificate issues, found as of 
# https://bugs.launchpad.net/ubuntu/+source/ca-certificates-java/+bug/983302
RUN apt-get update && \
	apt-get install -y ca-certificates-java && \
	apt-get clean && \
	update-ca-certificates -f && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;

# Setup JAVA_HOME, this is useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

RUN apt-get -y update && \
	apt-get -y install ant-contrib

RUN ant -version

FROM alpine
MAINTAINER John Vester <johnjvester@gmail.com>
RUN apk update
RUN apk add bash
RUN apk add openjdk8
RUN apk add apache-ant --update-cache \
	--repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
	--allow-untrusted
RUN apk add --update curl && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/bin/curl"]

ENV ANT_HOME /usr/share/java/apache-ant
ENV PATH $PATH:$ANT_HOME/bin
RUN ant -version
