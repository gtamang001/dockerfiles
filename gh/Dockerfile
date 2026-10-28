# Use the official Alpine base image
FROM artifactory.ssnc.dev/glo-docker/repos/alpine:latest

LABEL owner="ganga.tamang@ssninc.com"
# Install Git and the GitHub CLI
RUN apk update && apk add --no-cache \
    git \
    curl \
    && curl -fsSL https://github.com/cli/cli/releases/download/v2.34.0/gh_2.34.0_linux_amd64.tar.gz | tar xz \
    && mv gh_2.34.0_linux_amd64/bin/gh /usr/local/bin/gh \
    && rm -rf gh_2.34.0_linux_amd64

# Verify installations
RUN git --version && gh --version

# Set a working directory (optional)
WORKDIR /workspace

# Default command (optional)
CMD [ "sh" ]
