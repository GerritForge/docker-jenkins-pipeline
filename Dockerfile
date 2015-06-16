FROM jenkins

USER root

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y \
    python-pip \
    python-yaml \
    python-jenkins \
    ant \
    default-jdk \
    autoconf \
    automake \
    maven \
    vim \
    apparmor \
    wget

RUN wget -qO- https://get.docker.com/ | sh
RUN systemctl enable docker 
RUN rm -rf /var/lib/apt/lists/*

COPY plugins.sh /usr/local/bin/

USER root

ENV JENKINS_UC http://mirrors.clinkerhq.com/jenkins

COPY plugins.txt /usr/share/jenkins/ref/
RUN plugins.sh /usr/share/jenkins/ref/plugins.txt
COPY number-executors.groovy /usr/share/jenkins/ref/init.groovy.d/

COPY *xml /usr/share/jenkins/ref/

COPY .ssh/* /root/.ssh/
RUN chmod 600 /root/.ssh/id_rsa
RUN ssh -T -o StrictHostKeyChecking=no -o PasswordAuthentication=no git@github.com | true
RUN ssh -T -o StrictHostKeyChecking=no -o PasswordAuthentication=no -p 29418 gerritforgebuild@mesos1.gerritforge.com | true

RUN git config --global user.email "info@gerritforge.com"
RUN git config --global user.name "GerritForge Build"

COPY gitconfig /usr/share/jenkins/ref/.gitconfig
COPY http://stedolan.github.io/jq/download/linux64/jq /usr/bin/jq

COPY scm-sync-init.sh /usr/local/bin/
RUN /bin/bash -x /usr/local/bin/scm-sync-init.sh

ADD run.sh /user/bin/run.sh

CMD "run.sh"
