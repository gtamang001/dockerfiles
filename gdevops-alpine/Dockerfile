FROM artifactory.ssnc.dev/docker-repos/alpine:latest
LABEL maintainer="ganga.tamang@ssninc.com"

# ── Network testing ──────────────────────────────────────────────────────────
# curl/wget      : HTTP/HTTPS probing
# bind-tools     : dig, host, nslookup
# nmap           : port scanning
# netcat-openbsd : raw TCP/UDP connections
# inetutils-telnet: legacy telnet checks
# mtr            : combined ping+traceroute
# iperf3         : bandwidth measurement between pods
# tcpdump        : packet capture (requires NET_RAW capability in cluster)
# socat          : multipurpose relay / port-forward testing
# iproute2       : ip, ss — socket/route inspection
# iputils        : ping, arping
# net-tools      : netstat, ifconfig
# openssl        : TLS handshake / cert inspection
# openssh-client : SSH connectivity checks
# ngrep          : network grep for pattern matching
#
# ── Data processing ──────────────────────────────────────────────────────────
# jq             : JSON parsing and transformation
# yq             : YAML parsing and transformation
# python3        : scripting and data analysis
# py3-requests   : HTTP library for test scripts
# py3-yaml       : YAML support in Python scripts
# py3-netaddr    : IP/CIDR calculation in scripts
# py3-tabulate   : pretty-print tabular test results
# ─────────────────────────────────────────────────────────────────────────────
RUN apk update && \
    apk add --no-cache \
        bash \
        vim \
        ca-certificates \
        coreutils \
        tar \
        gzip \
        bzip2 \
        curl \
        wget \
        busybox-extras \
        bind-tools \
        nmap \
        nmap-ncat \
        netcat-openbsd \
        inetutils-telnet \
        mtr \
        iperf3 \
        tcpdump \
        socat \
        iproute2 \
        iputils \
        net-tools \
        openssl \
        openssh-client \
        ngrep \
        jq \
        yq \
        python3 \
        py3-pip \
        py3-requests \
        py3-yaml \
        py3-netaddr \
        py3-tabulate \
    && rm -rf /var/cache/apk/*

# ── Non-root user for cluster deployment ─────────────────────────────────────
# Kubernetes PodSecurityStandards (restricted/baseline) require non-root.
# UID/GID 1001 avoids collision with common system accounts.
ARG USER_UID=1001
ARG USER_GID=1001
RUN addgroup -g ${USER_GID} netops && \
    adduser -D -u ${USER_UID} -G netops netops && \
    mkdir -p /workspace && \
    chown netops:netops /workspace

WORKDIR /workspace

USER netops

# Keep the pod alive so exec / kubectl exec can reach it.
# Override CMD in your Deployment manifest if you need a custom entrypoint.
CMD ["tail", "-f", "/dev/null"]
