FROM amazonlinux:2.0.20190228

ARG BUILD_DATE
ARG VCS_REF
ARG SCHEMA_VERSION
ARG VERSION=3.28
ARG USER=jenkins
ARG GROUP=jenkins
ARG UID=1000
ARG GID=1000
ARG AGENT_WORKDIR=/home/${USER}/agent

LABEL maintainer="Paul Sladek" \
  org.label-schema.name="Jenkins Amazon Linux 2 JNLP slave base" \
  org.label-schema.description="Jenkins Amazon Linux 2 JNLP slave base" \
  org.label-schema.usage="/README.md" \
  org.label-schema.url="https://github.com/pbsladek/jenkins-amazonlinux2-jnlp-slave-base" \
  org.label-schema.vcs-url="git@github.com:pbsladek/jenkins-amazonlinux2-jnlp-slave-base.git" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.schema-version=$SCHEMA_VERSION

ENV HOME /home/${USER}
ENV AGENT_WORKDIR=${AGENT_WORKDIR}
ENV JAVA_HOME /usr/lib/jvm/java 

RUN amazon-linux-extras enable corretto8 && \
  yum clean metadata && \
  yum -y update && \
  yum -y install java-1.8.0-amazon-corretto-devel shadow-utils.x86_64 && \
  yum clean all && \
  rm -rf /var/cache/yum

RUN groupadd -g ${GID} ${GROUP}

RUN useradd -c "Jenkins user" -d $HOME -u ${UID} -g ${GID} -m ${USER}

RUN curl --create-dirs -fsSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar

USER ${USER}

RUN mkdir /home/${USER}/.jenkins && mkdir -p ${AGENT_WORKDIR}

VOLUME /home/${USER}/.jenkins

VOLUME ${AGENT_WORKDIR}

WORKDIR /home/${USER}
