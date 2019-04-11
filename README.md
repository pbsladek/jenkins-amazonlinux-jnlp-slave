Jenkins Amazon Linux JNLP slave base
===

[![Docker Stars](https://img.shields.io/docker/stars/pwbsladek/jenkins-amazonlinux2-jnlp-slave-base.svg)](https://hub.docker.com/r/pwbsladek/jenkins-amazonlinux2-jnlp-slave-base)
[![Docker Pulls](https://img.shields.io/docker/pulls/pwbsladek/jenkins-amazonlinux2-jnlp-slave-base.svg)](https://hub.docker.com/r/pwbsladek/jenkins-amazonlinux2-jnlp-slave-base)
[![Docker Automated build](https://img.shields.io/docker/automated/pwbsladek/jenkins-amazonlinux2-jnlp-slave-base.svg)](https://hub.docker.com/r/pwbsladek/jenkins-amazonlinux2-jnlp-slave-base)

## Description

Based on [jenkins/slave/ Dockerfile](https://hub.docker.com/r/jenkins/slave/dockerfile) and 
[jenkins/jnlp-slave/ Dockerfile](https://hub.docker.com/r/jenkins/jnlp-slave/dockerfile).

It seeks to maintain a general jenkins slave image that as a number of common utilities pre-installed.

This is a base image for Docker, which includes Java 8 via Amazon Corretto and the Jenkins agent executable (slave.jar). This executable is an instance of the [Jenkins Remoting library](https://github.com/jenkinsci/remoting).

## Usage

This image is used as the basis for the [Jenkins Amazon Linux 2 JNLP Agent](https://github.com/pbsladek/jenkins-amazonlinux2-jnlp-slave/) image.
In that image, the container is launched externally and attaches to Jenkins.

This image may instead be used to launch an agent using the **Launch method** of **Launch agent via execution of command on the master**. Try for example

```sh
docker run -i --rm --name agent --init pwbsladek/jenkins-amazonlinux2-jnlp-slave-base java -jar /usr/share/jenkins/slave.jar
```

after setting **Remote root directory** to `/home/jenkins/agent`.

### Agent Work Directories

Starting from [Remoting 3.8](https://github.com/jenkinsci/remoting/blob/master/CHANGELOG.md#38) there is a support of Work directories, 
which provides logging by default and change the JAR Caching behavior.

Call example:

```sh
docker run -i --rm --name agent1 --init -v agent1-workdir:/home/jenkins/agent pwbsladek/jenkins-amazonlinux2-jnlp-slave-base java -jar /usr/share/jenkins/slave.jar -workDir /home/jenkins/agent
```