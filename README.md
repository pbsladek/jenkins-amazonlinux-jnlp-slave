Jenkins Agent Apline Docker Image with Tools
===

[![Docker Stars](https://img.shields.io/docker/stars/jenkins/jnlp-slave.svg)](https://hub.docker.com/r/pwbsladek/jenkins-alpine-jnlp-slave)
[![Docker Pulls](https://img.shields.io/docker/pulls/jenkins/jnlp-slave.svg)](https://hub.docker.com/r/pwbsladek/jenkins-alpine-jnlp-slave)
[![Docker Automated build](https://img.shields.io/docker/automated/jenkins/jnlp-slave.svg)](https://hub.docker.com/r/pwbsladek/jenkins-alpine-jnlp-slave)

#Description

Based on [jenkins/slave/ Dockerfile](https://hub.docker.com/r/jenkins/slave/dockerfile) and 
[jenkins/jnlp-slave/ Dockerfile](https://hub.docker.com/r/jenkins/jnlp-slave/dockerfile).

It seeks to maintain a general jenkins slave image that as a number of common utilities pre-installed.

# Supported

### Java
    - junit
    - gradle
    - maven
    - 

## Usage

This image may instead be used to launch an agent using the **Launch method** of **Launch agent via execution of command on the master**. Try for example

```sh
docker run -i --rm --name agent --init jenkins/slave java -jar /usr/share/jenkins/slave.jar
```

after setting **Remote root directory** to `/home/jenkins/agent`.

### Agent Work Directories

Starting from [Remoting 3.8](https://github.com/jenkinsci/remoting/blob/master/CHANGELOG.md#38) there is a support of Work directories, 
which provides logging by default and change the JAR Caching behavior.

Call example:

```sh
docker run -i --rm --name agent1 --init -v agent1-workdir:/home/jenkins/agent jenkins/slave java -jar /usr/share/jenkins/slave.jar -workDir /home/jenkins/agent
```