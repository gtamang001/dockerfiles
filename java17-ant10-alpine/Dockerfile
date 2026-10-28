# Start with the latest stable Alpine base image
FROM artifactory.ssnc.dev/docker-repos/alpine:latest
LABEL maintainer="ganga.bomzan@gmail.com"

# Set environment variables for Java installation
ENV JAVA_VERSION=17
ENV ANT_VERSION=1.10.5
ENV ANT_HOME=/opt/ant

# Update package manager and install necessary packages
RUN apk update && \
    apk add --no-cache openjdk${JAVA_VERSION}-jre curl tar bash git

# Download and install Apache Ant
RUN mkdir -p ${ANT_HOME} && \
    curl -L https://archive.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz | \
    tar -xz --strip-components=1 -C ${ANT_HOME}

# Update PATH to include Ant binaries
ENV PATH=${ANT_HOME}/bin:$PATH

# Default command to run Ant build
CMD ["bash"]
