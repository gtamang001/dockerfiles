# Use the official Maven image based on Alpine Linux
FROM maven:3.8.8-eclipse-temurin-21-alpine
LABEL maintainer="ganga.bomzan@gmail.com"
# Set environment variables
ENV MAVEN_HOME=/usr/share/maven
ENV PATH="${MAVEN_HOME}/bin:${PATH}"

# Install additional packages
RUN apk add --no-cache \
    bash \
    curl \
    tar \
    zip \
    git

# Set the working directory
WORKDIR /app

# Set the default command
CMD ["bash"]
