FROM amazoncorretto:17

LABEL maintainer="ganga.bomzan@gmail.com"

ENV DEBIAN_FRONTEND=noninteractive \
    JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto \
    PATH="${JAVA_HOME}/bin:${PATH}"

# Install essential runtime tools and update certificates
# Amazon Corretto base image already includes Java and basic CA certificates
RUN yum update -y && \
    yum install -y \
        ca-certificates \
        curl \
        bash \
        tzdata \
        shadow-utils && \
    # Update OS CA certificates
    update-ca-trust && \
    # Import system CA certificates into Java truststore
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
    yum clean all && \
    rm -rf /var/cache/yum

WORKDIR /app

CMD ["bash"]
