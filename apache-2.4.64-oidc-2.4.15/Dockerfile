###########################################
# Stage 1: Build mod_jk and mod_auth_openidc
###########################################
ARG OIDC_VERSION=2.4.15.1
ARG MOD_JK_VERSION=1.2.50

FROM httpd:2.4.64 AS builder
ARG OIDC_VERSION
ARG MOD_JK_VERSION

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        build-essential \
        automake \
        autoconf \
        libtool \
        pkg-config \
        wget \
        ca-certificates \
        libssl-dev \
        libjansson-dev \
        libcurl4-openssl-dev \
        libcjose-dev \
        libhiredis-dev \
        libapr1-dev \
        libaprutil1-dev \
        libpcre2-dev \
        libldap2-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /src

###########################################
# Build mod_jk
###########################################
RUN wget https://dlcdn.apache.org/tomcat/tomcat-connectors/jk/tomcat-connectors-${MOD_JK_VERSION}-src.tar.gz || \
    wget https://archive.apache.org/dist/tomcat/tomcat-connectors/jk/tomcat-connectors-${MOD_JK_VERSION}-src.tar.gz && \
    tar xf tomcat-connectors-${MOD_JK_VERSION}-src.tar.gz && \
    cd tomcat-connectors-${MOD_JK_VERSION}-src/native && \
    ./configure --with-apxs=/usr/local/apache2/bin/apxs && \
    make

###########################################
# Build mod_auth_openidc
###########################################
RUN wget https://github.com/zmartzone/mod_auth_openidc/releases/download/v${OIDC_VERSION}/mod_auth_openidc-${OIDC_VERSION}.tar.gz && \
    tar xf mod_auth_openidc-${OIDC_VERSION}.tar.gz && \
    cd mod_auth_openidc-${OIDC_VERSION} && \
    ./configure --with-apxs=/usr/local/apache2/bin/apxs && \
    make

###########################################
# Stage 2: Reusable base image
#
# What's baked in:
#   - Apache HTTPD 2.4.64
#   - mod_auth_openidc (OIDC/OAuth2 authentication)
#   - mod_jk (AJP connector for Tomcat back-ends)
#   - All required runtime libraries
#
# What's NOT here (layer these on top):
#   - httpd.conf / vhost configs
#   - TLS certificates
#   - Application-specific content / static files
#   - Custom entrypoints
#
# Usage example:
#   FROM <this-image>
#   COPY conf/httpd.conf      /usr/local/apache2/conf/httpd.conf
#   COPY conf/extra/          /usr/local/apache2/conf/extra/
#
# The modules are pre-wired via conf/extra/oidc-jk-modules.conf,
# which the stock httpd.conf already includes. If you supply your own
# httpd.conf, add: Include conf/extra/oidc-jk-modules.conf
###########################################
FROM httpd:2.4.64
ARG OIDC_VERSION=2.4.15.1
ARG MOD_JK_VERSION=1.2.50
ARG VCS_REF
ENV TZ=America/New_York

LABEL org.opencontainers.image.title="apache-httpd-oidc-base" \
      org.opencontainers.image.description="Base image: Apache HTTPD 2.4.64 with mod_auth_openidc and mod_jk. No app config included — layer your own on top." \
      org.opencontainers.image.revision="${VCS_REF}" \
      maintainer="Ganga Tamang <ganga.tamang@ssinc.com>"

##############################################################
# Install runtime libraries (no build tools, no apache2-bin)
##############################################################
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        bash \
        tzdata \
        ca-certificates \
        curl \
        gettext-base \
        libcjose0 \
        libjansson4 \
        libcurl4 \
        libhiredis0.14 \
        libssl3 \
        libldap-2.5-0 \
        libsasl2-2 \
        libldap-common \
        libgnutls30 \
        libcap2 \
        libexpat1 && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

##############################################################
# Copy compiled modules from the builder stage
##############################################################
COPY --from=builder \
    /src/tomcat-connectors-${MOD_JK_VERSION}-src/native/apache-2.0/mod_jk.so \
    /usr/local/apache2/modules/mod_jk.so

COPY --from=builder \
    /src/mod_auth_openidc-${OIDC_VERSION}/.libs/mod_auth_openidc.so \
    /usr/local/apache2/modules/mod_auth_openidc.so

##############################################################
# Wire up modules and timezone
# Keeps LoadModule directives in a separate include file so
# child images can reuse them without redefining the paths.
##############################################################
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo "$TZ" > /etc/timezone && \
    printf 'LoadModule auth_openidc_module modules/mod_auth_openidc.so\nLoadModule jk_module modules/mod_jk.so\n' \
        > /usr/local/apache2/conf/extra/oidc-jk-modules.conf && \
    echo 'Include conf/extra/oidc-jk-modules.conf' >> /usr/local/apache2/conf/httpd.conf

##############################################################
# Validate all shared-library dependencies are satisfied
##############################################################
RUN echo "=== Verifying module runtime dependencies ===" && \
    ldd /usr/local/apache2/modules/mod_auth_openidc.so 2>&1 | tee /tmp/oidc_ldd.txt && \
    ! grep -q "not found" /tmp/oidc_ldd.txt && echo "mod_auth_openidc: all libs satisfied ✓" && \
    ldd /usr/local/apache2/modules/mod_jk.so 2>&1 | tee /tmp/jk_ldd.txt && \
    ! grep -q "not found" /tmp/jk_ldd.txt && echo "mod_jk: all libs satisfied ✓" && \
    rm /tmp/oidc_ldd.txt /tmp/jk_ldd.txt

EXPOSE 80 443

HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
    CMD /usr/local/apache2/bin/httpd -t || exit 1

CMD ["httpd-foreground"]
