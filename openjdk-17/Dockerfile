FROM openjdk:17.0.2-jdk
LABEL maintainer="ganga.bomzan@gmail.com"

ENV JAVA_HOME=/usr/java/openjdk-17 \
    PATH="${JAVA_HOME}/bin:${PATH}"

# Install essential runtime tools and update certificates
# OpenJDK base image already includes Java and basic CA certificates
RUN microdnf update -y && \
    microdnf install -y \
        ca-certificates \
        curl \
        shadow-utils && \
    # Update OS CA certificates
    update-ca-trust && \
    # Import system CA certificates into Java truststore
    # Using for loop to handle missing files gracefully
    for cert in /etc/pki/ca-trust/source/anchors/*.crt /etc/pki/tls/certs/*.pem; do \
        [ -f "$cert" ] || continue; \
        alias=$(basename "$cert" | sed 's/\.[^.]*$//' | tr '[:upper:]' '[:lower:]' | tr -cd '[:alnum:]_'); \
        keytool -import -noprompt -trustcacerts \
            -alias "system_${alias}" \
            -file "$cert" \
            -keystore "${JAVA_HOME}/lib/security/cacerts" \
            -storepass changeit 2>/dev/null || true; \
    done && \
    # Cleanup
    microdnf clean all && \
    rm -rf /var/cache/yum

WORKDIR /app

CMD ["bash"]