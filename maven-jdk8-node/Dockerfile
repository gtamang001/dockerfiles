# ================================
# Base image
# ================================
FROM debian:bookworm-slim

LABEL maintainer="ganga.bomzan@gmail.com"
LABEL description="Docker image with Node.js 22, Java 8, and Maven 3.9"

# ================================
# Build arguments
# ================================
ARG NODE_VERSION=22.11.0
ARG MAVEN_VERSION=3.9.9
ARG JAVA_HOME=/opt/java/openjdk

# ================================
# Environment variables
# ================================
ENV NODE_HOME=/opt/node \
    MAVEN_HOME=/opt/maven \
    JAVA_HOME=${JAVA_HOME} \
    PATH=/opt/node/bin:/opt/maven/bin:${JAVA_HOME}/bin:$PATH \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# ================================
# System dependencies
# ================================
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    git \
    tar \
    gzip \
    unzip \
    gnupg \
    bash \
    xz-utils \
 && rm -rf /var/lib/apt/lists/*


# ================================
# Install Java 8 (Temurin HotSpot)
# ================================
ARG JAVA_DIR=jdk8u352-b08
ARG JAVA_TARBALL=OpenJDK8U-jdk_x64_linux_hotspot_8u352b08.tar.gz

RUN mkdir -p /opt/java \
 && curl -fsSL \
    https://download.eclipse.org/temurin-compliance/temurin/8/${JAVA_DIR}/${JAVA_TARBALL} \
    | tar -xz -C /opt/java \
 && mv /opt/java/jdk8u* /opt/java/openjdk



# ================================
# Install Node.js 22
# ================================
RUN mkdir -p /opt/node \
 && curl -fsSL https://nodejs.org/dist/v22.11.0/node-v22.11.0-linux-x64.tar.xz \
    | tar -xJ --strip-components=1 -C /opt/node

# ================================
# Install Maven 3.9
# ================================
RUN mkdir -p /opt/maven \
 && curl -fL https://archive.apache.org/dist/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz \
 | tar -xz --strip-components=1 -C /opt/maven

# ================================
# Verify installations
# ================================
RUN java -version \
 && mvn -version \
 && node -v \
 && npm -v

# ================================
# Default command
# ================================
CMD ["bash"]
