FROM artifactory.ssnc.dev/glo-docker-local/glo-docker/maven-jdk21-alpine:6975285
LABEL maintainer="tcare@sscinc.com"

RUN apk update && apk add --no-cache \
  curl \
  zip \
  unzip

# install ant
RUN curl -jkSL -o /tmp/apache-ant.tar.gz https://dlcdn.apache.org//ant/binaries/apache-ant-1.9.16-bin.tar.gz && \
    gunzip /tmp/apache-ant.tar.gz && \
    tar -C /usr/local -xf /tmp/apache-ant.tar && \
	mv /usr/local/apache-ant-1.9.16 /usr/local/ant

#Set Ant Home in Docker container
ENV ANT_HOME=/usr/local/ant

#Update Path
ENV PATH="${PATH}:${HOME}/bin:${ANT_HOME}/bin"

CMD ["bash"]
