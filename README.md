# Jenkins CI Docker Image

	docker build -t jucc/jenkins-master .

To run on non-default port 8081 (Marathon uses 8080) go with:

	docker run -t -p 8081:8081 jucc/jenkins-master jenkins.sh --httpPort=8081


Available at:

  http://mesos3.gerritforge.com:8081/  juc / juc123
