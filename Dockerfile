FROM tomcat:8.0.20-jre8
# COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
COPY target/simpleapp*.war /usr/local/tomcat/webapps/simpleapp.war
