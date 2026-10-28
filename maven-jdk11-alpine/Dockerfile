FROM alpine:latest
LABEL maintainer="ganga.bomzan@gmail.com"

ENV MAVEN_VERSION=3.9.4 \
    JAVA_HOME=/usr/lib/jvm/java-11-openjdk \
    MAVEN_HOME=/usr/share/maven \
    PATH="$PATH:/usr/share/maven/bin:$JAVA_HOME/bin"

RUN apk add --no-cache openjdk11 bash curl tar git ca-certificates \
    && update-ca-certificates \
    && curl -fsSL https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    | tar -xz -C /usr/share \
    && ln -s /usr/share/apache-maven-${MAVEN_VERSION} /usr/share/maven \
    && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn \
    && keytool -importkeystore \
       -srckeystore /etc/ssl/certs/java/cacerts \
       -destkeystore $JAVA_HOME/lib/security/cacerts \
       -srcstorepass changeit \
       -deststorepass changeit -noprompt || true

WORKDIR /app
CMD ["bash"]