FROM tomcat:8
LABEL author="tangfeixiong<tangfx128@gmail.com" description="tomcat sample app"
COPY sample.war /usr/local/tomcat/webapps/
# VOLUME ["/usr/local/tomcat/webapps/sample"]
EXPOSE 8080
ENV CATALINA_OPTS "-Xms64M -Xmx256M -XX:PermSize=64m -XX:MaxPermSize=256m"
