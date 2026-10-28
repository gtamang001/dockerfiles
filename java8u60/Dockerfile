FROM artifacts-scm.dstcorp.net/docker-repos/centos:7
COPY jdk-8u60-linux-x64.rpm .
COPY apache-maven-3.8.5-bin.tar.gz .
RUN yum localinstall -y jdk-8u60-linux-x64.rpm && \
    rm jdk-8u60-linux-x64.rpm && \
    mkdir -p /usr/local/maven && \
    tar xf apache-maven-3.8.5-bin.tar.gz -C /usr/local/maven && \
    rm apache-maven-3.8.5-bin.tar.gz && \
    yum clean all

ENV JAVA_HOME=/usr/java/jdk1.8.0_60/ \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    PATH=$PATH:/usr/local/maven/apache-maven-3.8.5/bin