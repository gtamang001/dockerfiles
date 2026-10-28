FROM almalinux:latest
LABEL maintainer="ganga.bomzan@gmail.com"
RUN dnf upgrade --refresh -y
RUN dnf install 'dnf-command(config-manager)' -y
RUN dnf config-manager --set-enabled crb
RUN dnf install epel-release -y
RUN dnf install epel-next-release -y
RUN dnf install hiredis httpd cjose cronolog mod_jk wget -y
RUN wget --no-check-certificate https://github.com/OpenIDC/mod_auth_openidc/releases/download/v2.4.14.4/mod_auth_openidc-2.4.14.4-1.el9.x86_64.rpm && rpm -ivh mod_auth_openidc-2.4.14.4-1.el9.x86_64.rpm

RUN rm mod_auth_openidc-2.4.14.4-1.el9.x86_64.rpm 

CMD bash