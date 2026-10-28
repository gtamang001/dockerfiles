FROM artifactory.ssnc.dev/docker-repos/httpd:latest
ENV HOME_DIR=/home/navpack
RUN apt-get update && apt-get install -y dos2unix openssh-server
RUN groupadd --gid 1200 cgnos && adduser --disabled-password --home $HOME_DIR --gecos "" --uid 1200 --gid 1200 navpack
WORKDIR $HOME_DIR
RUN mkdir -p conf logs/archived .ssh
RUN echo "KexAlgorithms +diffie-hellman-group1-sha1,diffie-hellman-group14-sha1 \n\
          PubkeyAcceptedAlgorithms +ssh-rsa \n\
          HostKeyAlgorithms +ssh-rsa \n\
          StrictHostKeyChecking no" >> /etc/ssh/ssh_config


# COPY start.sh start.sh
# RUN dos2unix start.sh
# RUN chmod +x start.sh
RUN chown -R navpack:cgnos $HOME_DIR
RUN chmod 700 .ssh
USER navpack
ENTRYPOINT ["httpd", "-D", "FOREGROUND"]