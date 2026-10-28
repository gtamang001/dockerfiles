FROM artifactory.ssnc.dev/docker-repos/alpine:latest

# ---------- Metadata ----------
LABEL maintainer="ganga.bomzan@gmail.com" \
      org.opencontainers.image.title="java25-maven-alpine" \
      org.opencontainers.image.description="Minimal Java 25 + Maven base image with essential utilities" \
      org.opencontainers.image.vendor="SSNC"

# ---------- Environment ----------
ENV JAVA_HOME=/usr/lib/jvm/java-25-openjdk \
    MAVEN_HOME=/usr/share/maven \
    PATH=$PATH:/usr/share/maven/bin:$JAVA_HOME/bin

# ---------- Install Packages ----------
RUN set -eux; \
    apk add --no-cache \
        openjdk25 \
        maven \
        bash \
        curl \
        git \
        tar \
        zip \
        unzip \
        ca-certificates \
    ; \
    update-ca-certificates; \
    \
    # Clean up
    rm -rf /var/cache/apk/* /tmp/* /root/.m2

# ---------- Create Non-root User ----------
# RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# ---------- Workdir ----------
# WORKDIR /app

# ---------- Validate Install ----------
# RUN java -version && mvn -version

# ---------- Switch User ----------
# USER appuser

# ---------- Default ----------
CMD ["bash"]
