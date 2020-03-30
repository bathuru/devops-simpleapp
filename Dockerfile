FROM tomcat:8.0.20-jre8
# Dummy text to test 
COPY /home/ec2-user/workspace/simpleapp/target/simpleapp*.war /usr/local/tomcat/webapps/simpleapp.war
