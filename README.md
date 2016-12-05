## Content

### Build

For example Tomcat 7 with Oracle Server JRE 7, CentOS 7 base

    [vagrant@localhost tomcat-docker]$ docker build --no-cache -t tangfeixiong/tomcat:7-serverjre7-centos7 -f 7.0.73/Dockerfile.apache-tomcat-7%2E0%2E73%2Etar%2Egz.server-jre-7u80-linux-x64%2Etar%2Egz.centos%3Acentos7 .

_sample.war_

    [vagrant@localhost tomcat]$ curl -jkSL http://tomcat.apache.org/tomcat-6.0-doc/appdev/sample/sample.war -O

_administrator_

    tangf@DESKTOP-H68OQDV /cygdrive/f/99-mirror/https%3A%2F%2Fwww.apache.org%2Fdist%2Ftomcat/apache-tomcat-7.0.73/conf
    $ sed 's/.*<\/tomcat-users>.*/  <role rolename="manager-gui"\/>\n  <role rolename="admin-gui"\/>\n  <user username="admin" password="admin123" roles="manager-gui,admin-gui"\/>\n&/' tomcat-users.xml

### Kubernetes

    [vagrant@localhost tomcat-docker]$ KUBECONFIG=/home/vagrant/.pki/kubernetes/kubeconfig kubectl run tomcat7 --image=tangfeixiong/tomcat:7-serverjre7-centos7
    
    [vagrant@localhost tomcat-docker]$ KUBECONFIG=/home/vagrant/.pki/kubernetes/kubeconfig kubectl expose deployments/tomcat7 --port=8080 --type=NodePort
    
    [vagrant@localhost tomcat-docker]$ KUBECONFIG=/home/vagrant/.pki/kubernetes/kubeconfig kubectl get deployments/tomcat7 -o ymal > kuberntes/tomcat7-deployment.yaml
    
    [vagrant@localhost tomcat-docker]$ KUBECONFIG=/home/vagrant/.pki/kubernetes/kubeconfig kubectl get service/tomcat7 -o ymal > kuberntes/tomcat7-service.yaml
    
    [vagrant@localhost tomcat-docker]$ KUBECONFIG=/home/vagrant/.pki/kubernetes/kubeconfig && kubectl get pods/$(kubectl get pods -l run=tomcat7 --no-headers | awk '{print $1}') -o ymal > kuberntes/tomcat7-pod.yaml


### Validate

    [vagrant@localhost tomcat-docker]$ docker run -t --rm tangfeixiong/tomcat:7-serverjre7-centos7
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.VersionLoggerListener log INFO: Server version:        Apache Tomcat/7.0.73
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.VersionLoggerListener log INFO: Server built:          Nov 7 2016 21:27:23 UTC
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.VersionLoggerListener log INFO: Server number:         7.0.73.0
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.VersionLoggerListener log INFO: OS Name:               Linux
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.VersionLoggerListener log INFO: OS Version:            4.7.10-100.fc23.x86_64
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.VersionLoggerListener log INFO: Architecture:          amd64
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.VersionLoggerListener log INFO: Java Home:             /opt/java/jre
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.VersionLoggerListener log INFO: JVM Version:           1.7.0_80-b15
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.VersionLoggerListener log INFO: JVM Vendor:            Oracle Corporation
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.VersionLoggerListener log INFO: CATALINA_BASE:         /opt/tomcat
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.VersionLoggerListener log INFO: CATALINA_HOME:         /opt/tomcat
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.VersionLoggerListener log INFO: Command line argument: -Djava.util.logging.config.file=/opt/tomcat/conf/logging.properties
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.VersionLoggerListener log INFO: Command line argument: -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.VersionLoggerListener log INFO: Command line argument: -Djdk.tls.ephemeralDHKeySize=2048
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.VersionLoggerListener log INFO: Command line argument: -Xms64m
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.VersionLoggerListener log INFO: Command line argument: -Xmx256m
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.VersionLoggerListener log INFO: Command line argument: -XX:PermSize=64m
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.VersionLoggerListener log INFO: Command line argument: -XX:MaxPermSize=256
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.VersionLoggerListener log INFO: Command line argument: -Djava.endorsed.dirs=/opt/tomcat/endorsed
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.VersionLoggerListener log INFO: Command line argument: -Dcatalina.base=/opt/tomcat
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.VersionLoggerListener log INFO: Command line argument: -Dcatalina.home=/opt/tomcat
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.VersionLoggerListener log INFO: Command line argument: -Djava.io.tmpdir=/opt/tomcat/temp
    Dec 03, 2016 4:50:04 PM org.apache.catalina.core.AprLifecycleListener lifecycleEvent INFO: Loaded APR based Apache Tomcat Native library 1.2.10 using APR version 1.4.8.
    Dec 03, 2016 4:50:04 PM org.apache.catalina.core.AprLifecycleListener lifecycleEvent INFO: APR capabilities: IPv6 [true], sendfile [true], accept filters [false], random [true].
    Dec 03, 2016 4:50:04 PM org.apache.catalina.core.AprLifecycleListener initializeSSL INFO: OpenSSL successfully initialized (OpenSSL 1.0.2j  26 Sep 2016)
    Dec 03, 2016 4:50:04 PM org.apache.coyote.AbstractProtocol init INFO: Initializing ProtocolHandler ["http-apr-8080"]
    Dec 03, 2016 4:50:04 PM org.apache.coyote.AbstractProtocol init INFO: Initializing ProtocolHandler ["ajp-apr-8009"]
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.Catalina load INFO: Initialization processed in 1085 ms
    Dec 03, 2016 4:50:04 PM org.apache.catalina.core.StandardService startInternal INFO: Starting service Catalina
    Dec 03, 2016 4:50:04 PM org.apache.catalina.core.StandardEngine startInternal INFO: Starting Servlet Engine: Apache Tomcat/7.0.73
    Dec 03, 2016 4:50:04 PM org.apache.catalina.startup.HostConfig deployDirectory INFO: Deploying web application directory /opt/tomcat/webapps/ROOT
    Dec 03, 2016 4:50:05 PM org.apache.catalina.startup.HostConfig deployDirectory INFO: Deployment of web application directory /opt/tomcat/webapps/ROOT has finished in 758 ms
    Dec 03, 2016 4:50:05 PM org.apache.catalina.startup.HostConfig deployDirectory INFO: Deploying web application directory /opt/tomcat/webapps/docs
    Dec 03, 2016 4:50:05 PM org.apache.catalina.startup.HostConfig deployDirectory INFO: Deployment of web application directory /opt/tomcat/webapps/docs has finished in 97 ms
    Dec 03, 2016 4:50:05 PM org.apache.catalina.startup.HostConfig deployDirectory INFO: Deploying web application directory /opt/tomcat/webapps/examples
    Dec 03, 2016 4:50:06 PM org.apache.catalina.startup.HostConfig deployDirectory INFO: Deployment of web application directory /opt/tomcat/webapps/examples has finished in 462 ms
    Dec 03, 2016 4:50:06 PM org.apache.catalina.startup.HostConfig deployDirectory INFO: Deploying web application directory /opt/tomcat/webapps/host-manager
    Dec 03, 2016 4:50:06 PM org.apache.catalina.startup.HostConfig deployDirectory INFO: Deployment of web application directory /opt/tomcat/webapps/host-manager has finished in 98 ms
    Dec 03, 2016 4:50:06 PM org.apache.catalina.startup.HostConfig deployDirectory INFO: Deploying web application directory /opt/tomcat/webapps/manager
    Dec 03, 2016 4:50:06 PM org.apache.catalina.startup.HostConfig deployDirectory INFO: Deployment of web application directory /opt/tomcat/webapps/manager has finished in 77 ms
    Dec 03, 2016 4:50:06 PM org.apache.coyote.AbstractProtocol start INFO: Starting ProtocolHandler ["http-apr-8080"]
    Dec 03, 2016 4:50:06 PM org.apache.coyote.AbstractProtocol start INFO: Starting ProtocolHandler ["ajp-apr-8009"]
    Dec 03, 2016 4:50:06 PM org.apache.catalina.startup.Catalina start INFO: Server startup in 1644 ms    