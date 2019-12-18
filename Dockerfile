FROM libary/ubuntu

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
    sfdx update && \
    sfdx force --help && \
    apt-get install -y openjdk-8-jdk && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer && \
	apt-get update && \
	apt-get install -y ca-certificates-java && \
	apt-get clean && \
	update-ca-certificates -f && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer && \
    apt-get update && \
	apt-get -y install ant && \
    apt-get update && \
	apt-get -y install ant-contrib && \
    apt-get -y install jq && \
	apt-get install curl && \
	apt-get update && \
	apt-get -y install software-properties-common python-software-properties && \
	add-apt-repository ppa:fkrull/deadsnakes && \
	apt-get update && \
	apt-get -y install python3.6 && \
	python3 --version;

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME