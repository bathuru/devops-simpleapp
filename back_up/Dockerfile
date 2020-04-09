FROM tomcat:8.0.20-jre8
MAINTAINER srinivas.bathuru@gmail.com
ENV TOMCAT_PATH /usr/local/tomcat/webapps

# COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
COPY target/simpleapp*.war $TOMCAT_PATH/simpleapp.war
EXPOSE 8080
