FROM tomcat
COPY tomcat-users.xml /usr/local/tomcat/conf/
COPY manager.xml /usr/local/tomcat/conf/Catalina/localhost/
COPY context.xml /usr/local/tomcat/webapps/host-manager/META-INF/
ADD target/smtk-v1.war /usr/local/tomcat/webapps/

EXPOSE 8080
