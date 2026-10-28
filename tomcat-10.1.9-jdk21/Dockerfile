# ---------- Stage 1: Builder ----------
FROM artifactory.ssnc.dev/docker-repos/eclipse-temurin:21-jdk AS builder

ENV TOMCAT_VERSION=10.1.9 \
    CATALINA_HOME=/opt/tomcat

WORKDIR /opt

# Install wget (curl not always present in base image) and download Tomcat
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://archive.apache.org/dist/tomcat/tomcat-10/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    tar -xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    mv apache-tomcat-${TOMCAT_VERSION} tomcat && \
    rm -rf tomcat/webapps/* && \
    rm -f apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    apt-get purge -y --auto-remove wget && \
    rm -rf /var/lib/apt/lists/*

# ---------- Stage 2: Final Image ----------
FROM artifactory.ssnc.dev/docker-repos/eclipse-temurin:21-jre

ENV CATALINA_HOME=/opt/tomcat
WORKDIR /opt/tomcat

# Create non-root user
RUN useradd -r -m -d /opt/tomcat -s /usr/sbin/nologin tomcat

# Copy built Tomcat
COPY --from=builder /opt/tomcat /opt/tomcat

# Ensure permission for non-root user
RUN chown -R tomcat:tomcat /opt/tomcat

USER tomcat

CMD ["bash"]
