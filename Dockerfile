FROM jenkins

USER root

RUN apt-get update && apt-get install -y \
    python-pip \
    python-yaml \
    python-jenkins \
    ant \
    default-jdk \
    autoconf \
    automake \
    maven \
    vim

RUN rm -rf /var/lib/apt/lists/*

COPY plugins.sh /usr/local/bin/

USER jenkins

ENV JENKINS_UC http://mirrors.clinkerhq.com/jenkins

COPY plugins.txt /usr/share/jenkins/ref/
RUN plugins.sh /usr/share/jenkins/ref/plugins.txt
COPY number-executors.groovy /usr/share/jenkins/ref/init.groovy.d/

COPY gitconfig /usr/share/jenkins/ref/.gitconfig
