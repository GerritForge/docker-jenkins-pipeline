#!/bin/bash
mkdir /usr/share/jenkins/ref/scm-sync-configuration 
cd /usr/share/jenkins/ref/scm-sync-configuration
git clone git@github.com:GerritForge/docker-jenkins-jobs.git checkoutConfiguration
cd checkoutConfiguration
cp -Rf * /usr/share/jenkins/ref/.
