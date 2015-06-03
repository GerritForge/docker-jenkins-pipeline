#!/bin/bash
mkdir /usr/share/jenkins/ref/scm-sync-configuration 
cd /usr/share/jenkins/ref/scm-sync-configuration
git clone git@github.com:GerritForge/docker-jenkins-config.git checkoutConfiguration
cd checkoutConfiguration
cp -Rf * /usr/share/jenkins/ref/.
