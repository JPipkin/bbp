FROM library/ubuntu

########### SFDX ###########
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
    
########### JDK8 ###########
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
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

########### ANT & ANT-CONTRIB ###########
RUN apt-get update && \
	apt-get -y install ant && \
    apt-get update && \
	apt-get -y install ant-contrib

########### JQ ###########
RUN apt-get -y install jq

########### CURL ###########
RUN apt-get install curl

########### PYTHON3 ###########
RUN apt-get update && \
	apt-get -y install software-properties-common python-software-properties && \
	add-apt-repository ppa:fkrull/deadsnakes && \
	apt-get update && \
	apt-get -y install python3.6 && \
	python3 --version