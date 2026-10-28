FROM alpine:latest

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk \
    PATH=$PATH:/usr/lib/jvm/java-21-openjdk/bin

# Install JRE 21 only
RUN apk add --no-cache \
    openjdk21-jre && \
    # Remove potential extra files
    rm -rf /var/cache/apk/* /tmp/*

# Set working directory
WORKDIR /app

CMD [ "bash" ]