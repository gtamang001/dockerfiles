# Use Alpine Linux as base image
FROM artifactory.ssnc.dev/docker-repos/alpine:3.22.0
LABEL maintainer="ganga.tamang@ssninc.com"
# Update package lists and install required packages
RUN apk update && \
    apk add --no-cache \     
        vim \            
        bash \
        git \
        curl \
        jq
CMD ["bash"]