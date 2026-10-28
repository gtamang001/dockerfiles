FROM openjdk:8

RUN apt-get update \
  && apt-get install -y curl \
  && apt-get install -y zip \
  && apt-get install -y unzip

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
