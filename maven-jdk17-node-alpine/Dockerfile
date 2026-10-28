# Use a valid Maven + JDK 17 Alpine image
FROM artifactory.ssnc.dev/glo-docker-local/glo-docker/maven-jdk17-alpine:6042031

# Install Node.js v18 and npm using Alpine's package manager
RUN apk add --no-cache nodejs npm

# Optional: Install Angular CLI globally
RUN npm install -g @angular/cli@15.1.5

# Verify installations
RUN node -v && npm -v && mvn -v

# Set working directory
WORKDIR /app
