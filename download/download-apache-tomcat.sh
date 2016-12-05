#!/bin/bash

### http://tomcat.apache.org/download-70.cgi#Mirrors
# http://mirrors.cnnic.cn/apache/tomcat/tomcat-7/v7.0.73/bin/apache-tomcat-7.0.73.tar.gz
# https://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-7/v7.0.73/bin/apache-tomcat-7.0.73.tar.gz
# http://www-us.apache.org/dist/tomcat/tomcat-7/v7.0.73/
# http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.73/

curl -jkSL http://mirrors.cnnic.cn/apache/tomcat/tomcat-7/v7.0.73/bin/apache-tomcat-7.0.73.tar.gz -O
curl -jkSL https://www.apache.org/dist/tomcat/tomcat-7/v7.0.73/bin/apache-tomcat-7.0.73.tar.gz.asc -O
curl -jkSL https://www.apache.org/dist/tomcat/tomcat-7/KEYS -o apache-tomcat-7.0.73.KEYS
