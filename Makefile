
TOMCAT ?= 7.0.73
JAVA ?= server-jre-7u80

.PHONY: all tomcat7 tomcat8

all: tomcat7 tomcat8

build tomcat7:
    ./build-docker-images.sh

tomcat8: