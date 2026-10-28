# Use an appropriate base image
FROM openjdk:8

LABEL maintainer="ganga.bomzan@gmail.com"
ARG ANT_VERSION=1.10.13

ENV ANT_HOME /opt/ant
ENV PATH $ANT_HOME/bin:$PATH

RUN apt-get update && \
    apt-get install -y wget curl unzip build-essential && \
    rm -rf /var/lib/apt/lists/*

# install ant
RUN wget https://archive.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz -P /tmp && \
    tar xf /tmp/apache-ant-${ANT_VERSION}-bin.tar.gz -C /opt && \
    ln -s /opt/apache-ant-${ANT_VERSION} /opt/ant && \
    rm /tmp/apache-ant-${ANT_VERSION}-bin.tar.gz

# install glibc
# RUN wget https://ftp.gnu.org/gnu/libc/glibc-${GLIBC_VERSION}.tar.gz -P /tmp && \
#     tar xf /tmp/glibc-${GLIBC_VERSION}.tar.gz -C /tmp && \
#     cd /tmp/glibc-${GLIBC_VERSION} && \
#     mkdir build && \
#     cd build && \
#     ../configure --prefix=/usr && \
#     make -j$(nproc) && \
#     make install && \
#     cd / && \
#     rm -rf /tmp/glibc-${GLIBC_VERSION} /tmp/glibc-${GLIBC_VERSION}.tar.gz

# Command to keep the container running
CMD ["bash"]
