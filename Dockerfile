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

USER root

ENV JENKINS_UC http://mirrors.clinkerhq.com/jenkins

COPY plugins.txt /usr/share/jenkins/ref/
RUN plugins.sh /usr/share/jenkins/ref/plugins.txt
COPY number-executors.groovy /usr/share/jenkins/ref/init.groovy.d/

COPY *xml /var/jenkins_home/

COPY .ssh/* /root/.ssh/
RUN chmod 600 /root/.ssh/id_rsa
RUN ssh -T -o StrictHostKeyChecking=no -o PasswordAuthentication=no git@github.com | true

RUN git config --global user.email "info@gerritforge.com"
RUN git config --global user.name "GerritForge Build"

COPY gitconfig /usr/share/jenkins/ref/.gitconfig

RUN curl -OL https://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/0.13.8/sbt-launch.jar
RUN mv sbt-launch.jar /usr/share/
