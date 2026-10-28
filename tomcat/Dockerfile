FROM openjdk:8-jre-slim-buster
LABEL maintainer="ganga.bomzan@gmail.com"
RUN apt update && apt install curl -y
RUN mkdir /opt/tomcat/

WORKDIR /opt/tomcat
RUN curl -O https://downloads.apache.org/tomcat/tomcat-8/v8.5.83/bin/apache-tomcat-8.5.83.tar.gz

RUN tar xvfz apache*.tar.gz && mv apache-tomcat-8.5.83/* /opt/tomcat/. && rm apache-tomcat-8.5.83.tar.gz && rm -rf apache-tomcat-8.5.83

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]