FROM eclipse-temurin:17-jdk-jammy
LABEL maintainer="ganga.bomzan@gmail.com"

ENV JAVA_HOME=/opt/java/openjdk \
    PATH="$PATH:$JAVA_HOME/bin"

# Install essential runtime tools and update certificates
# Note: Eclipse Temurin base image already includes a comprehensive set of CA certificates
# This ensures system certs are up-to-date and adds any additional system certs to Java truststore
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        bash && \
    update-ca-certificates && \
    # Import system CA certificates into Java truststore for future cert changes
    # Ubuntu stores CA certs in /etc/ssl/certs as individual .crt files
    for cert in /etc/ssl/certs/*.pem; do \
        [ -f "$cert" ] || continue; \
        alias=$(basename "$cert" .pem | tr '[:upper:]' '[:lower:]' | tr -cd '[:alnum:]_'); \
        keytool -import -noprompt -trustcacerts \
            -alias "system_$alias" \
            -file "$cert" \
            -keystore $JAVA_HOME/lib/security/cacerts \
            -storepass changeit 2>/dev/null || true; \
    done && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

CMD ["bash"]
