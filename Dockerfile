FROM amazonlinux:2.0.20190228

ARG BUILD_DATE
ARG VCS_REF
ARG SCHEMA_VERSION
ARG VERSION=3.28
ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG AGENT_WORKDIR=/home/${user}/agent

LABEL maintainer="Paul Sladek" \
  org.label-schema.name="Jenkins Amazon Linux 2 jnlp slave base" \
  org.label-schema.description="Jenkins Amazon Linux 2 jnlp slave base" \
  org.label-schema.usage="/README.md" \
  org.label-schema.url="https://github.com/pbsladek/jenkins-amazonlinux2-jnlp-slave-base" \
  org.label-schema.vcs-url="git@github.com:pbsladek/jenkins-amazonlinux2-jnlp-slave-base.git" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.schema-version=$SCHEMA_VERSION

ENV HOME /home/${user}
ENV AGENT_WORKDIR=${AGENT_WORKDIR}

RUN yum install shadow-utils.x86_64 -y && amazon-linux-extras install corretto8

RUN groupadd -g ${gid} ${group}

RUN useradd -c "Jenkins user" -d $HOME -u ${uid} -g ${gid} -m ${user}

RUN curl --create-dirs -fsSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar

USER ${user}

RUN mkdir /home/${user}/.jenkins && mkdir -p ${AGENT_WORKDIR}

VOLUME /home/${user}/.jenkins
VOLUME ${AGENT_WORKDIR}
WORKDIR /home/${user}