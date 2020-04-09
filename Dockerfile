FROM tomcat:8.0.20-jre8
MAINTAINER srinivas.bathuru@gmail.com
ENV TOMCAT_PATH /usr/local/tomcat/webapps/

 WORKDIR /usr/local/tomcat/webapps/
 RUN pwd
 RUN echo "TOMCAT_PATH = "  $TOMCAT_PATH

COPY target/simpleapp*.war /usr/local/tomcat/webapps/simpleapp.war

EXPOSE 8080

# COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
# COPY target/simpleapp*.war /usr/local/tomcat/webapps/simpleapp.war
