FROM alpine:3.17
LABEL maintainer="ganga.bomzan@gmail.com"
# Set environment variables
ENV KUBECTL_VERSION=v1.28.0 \
    HELM_VERSION=v3.14.0 \
    KUSTOMIZE_VERSION=5.3.0

# Install packages and tools
RUN apk add --no-cache \
      curl \
      wget \
      git \
      vim \
      bash \
      ca-certificates \
      tar \
      gzip \
      libc6-compat && \
    \
    # Install kubectl
    curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl && \
    \
    # Install helm
    curl -LO "https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz" && \
    tar -xzvf helm-${HELM_VERSION}-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    rm -rf linux-amd64 helm-${HELM_VERSION}-linux-amd64.tar.gz && \
    \
    # Install kustomize
    curl -s "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz" -L -o kustomize.tar.gz && \
    tar -xzf kustomize.tar.gz && \
    mv kustomize /usr/local/bin/kustomize && \
    rm kustomize.tar.gz

# Default shell
CMD ["/bin/bash"]
