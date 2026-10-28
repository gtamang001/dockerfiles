# Use an official JDK 8 base image
FROM openjdk:8-jdk

# Set environment variables for Ant and Tomcat versions
ENV ANT_VERSION=1.10.15 \
    TOMCAT_VERSION=9.0.98 \
    CATALINA_HOME=/opt/tomcat \
    PATH="$PATH:/opt/ant/bin:/opt/tomcat/bin"

# Install required tools and dependencies
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install Apache Ant
RUN wget https://downloads.apache.org/ant/binaries/apache-ant-${ANT_VERSION}-bin.zip \
    -O /tmp/apache-ant.zip \
    && unzip /tmp/apache-ant.zip -d /opt/ \
    && ln -s /opt/apache-ant-${ANT_VERSION} /opt/ant \
    && rm /tmp/apache-ant.zip

# Install Tomcat
RUN wget https://downloads.apache.org/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz \
    -O /tmp/apache-tomcat.tar.gz \
    && mkdir -p $CATALINA_HOME \
    && tar -xvf /tmp/apache-tomcat.tar.gz -C $CATALINA_HOME --strip-components=1 \
    && rm /tmp/apache-tomcat.tar.gz

# Expose Tomcat default port
EXPOSE 8080

# Set working directory
WORKDIR $CATALINA_HOME

# Start Tomcat by default
CMD ["catalina.sh", "run"]
