FROM alpine:latest

LABEL maintainer="ganga.tamang@sscin.com"
# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk \
    ANT_VERSION=1.10.14 \
    ANT_HOME=/opt/ant \
    PATH=$PATH:/opt/ant/bin

# Install Java 8 and tar only
RUN apk add --no-cache \
    openjdk8 \
    git \
    curl \
    bash \
    tar

# Copy Ant tarball from local build context
COPY apache-ant-1.10.14-bin.tar.gz /tmp/ant.tar.gz

# Extract and configure
RUN tar -xzf /tmp/ant.tar.gz -C /opt && \
    ln -s /opt/apache-ant-${ANT_VERSION} /opt/ant && \
    rm -rf /tmp/*
    
# Default command
CMD [ "ant", "-version" ]
