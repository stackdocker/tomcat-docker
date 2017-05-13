动手：开发Tomcat应用的Docker镜像
=============================

Tables of Content
------------------

* 准备
* Tomcat官方镜像
* 手工制作（示例Tomcat的sample.war）
* 命令过程转换为Dockerfile
* Next

Content
-------

### 准备

Linux系统

Docker Engine > 1.9，例如：
```
vagrant@vagrant-ubuntu-trusty-64:~$ docker version
Client:
 Version:      1.10.3
 API version:  1.22
 Go version:   go1.5.3
 Git commit:   20f81dd
 Built:        Thu Mar 10 15:54:52 2016
 OS/Arch:      linux/amd64

Server:
 Version:      1.10.3
 API version:  1.22
 Go version:   go1.5.3
 Git commit:   20f81dd
 Built:        Thu Mar 10 15:54:52 2016
 OS/Arch:      linux/amd64
```

### Tomcat基础镜像

Docker Hub上发布的[Tomcat官方镜像](https://hub.docker.com/_/tomcat/)

示例Tomcat 8 (jre8)：
```
vagrant@vagrant-ubuntu-trusty-64:~$ docker pull tomcat:8
8: Pulling from library/tomcat
cd0a524342ef: Already exists 
e39c3ffe4133: Pull complete 
aac3320edf40: Pull complete 
4d9e109682f7: Pull complete 
0a59efcf9553: Pull complete 
b6b666d261d3: Pull complete 
98430ee944b3: Pull complete 
0670b9fca612: Pull complete 
64173c6ab0a9: Pull complete 
27484487c235: Pull complete 
36f785895b0e: Pull complete 
25959657b999: Pull complete 
71adfadc8918: Pull complete 
e1c91ea5caeb: Pull complete 
Digest: sha256:ced5c004228aaf5c13763b2ce52a30c946a8b9fd010cd5a1c743bdfb01d04b0f
Status: Downloaded newer image for tomcat:8
vagrant@vagrant-ubuntu-trusty-64:~$ docker images tomcat
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
tomcat              8                   08f8166740f8        7 days ago          366.7 MB
```

示例Tomcat 7 (jre8)
```
vagrant@vagrant-ubuntu-trusty-64:~$ docker pull tomcat:7-jre8
7-jre8: Pulling from library/tomcat
cd0a524342ef: Already exists 
e39c3ffe4133: Already exists 
aac3320edf40: Already exists 
4d9e109682f7: Already exists 
0a59efcf9553: Already exists 
b6b666d261d3: Already exists 
98430ee944b3: Already exists 
0670b9fca612: Already exists 
64173c6ab0a9: Already exists 
27484487c235: Already exists 
36f785895b0e: Already exists 
25959657b999: Already exists 
7531f72cfab0: Pull complete 
719c95698988: Pull complete 
Digest: sha256:aa962891d8f3c13d901923beaf815a916bc7f4082172d2b22b1df226c47b039c
Status: Downloaded newer image for tomcat:7-jre8
vagrant@vagrant-ubuntu-trusty-64:~$ docker images tomcat
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
tomcat              8                   08f8166740f8        7 days ago          366.7 MB
tomcat              7-jre8              03164aa6718b        7 days ago          367.2 MB
```

深入学习，参考[Docker文档库之Tomcat](https://github.com/docker-library/docs/tree/master/tomcat)和[Tomcat镜像开发文档](https://github.com/docker-library/tomcat)

### 手工制作

获取Tomcat的sample.war, 参考[链接](https://tomcat.apache.org/tomcat-8.0-doc/appdev/sample/)
```
vagrant@vagrant-ubuntu-trusty-64:~$ mkdir -p /work/src/github.com/stackdocker/tomcat-docker/download/tomcat
vagrant@vagrant-ubuntu-trusty-64:~$ cd /work/src/github.com/stackdocker/tomcat-docker/download/tomcat/
vagrant@vagrant-ubuntu-trusty-64:/work/src/github.com/stackdocker/tomcat-docker/download/tomcat$ curl -jkSL https://tomcat.apache.org/tomcat-8.0-doc/appdev/sample/sample.war -O
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  4606  100  4606    0     0   2643      0  0:00:01  0:00:01 --:--:--  2642
vagrant@vagrant-ubuntu-trusty-64:/work/src/github.com/stackdocker/tomcat-docker/download/tomcat$ ls -l sample.war
-rw-r--r-- 1 vagrant vagrant 4.5K May 13 04:46 sample.war
```

创建tomcat容器
```
vagrant@vagrant-ubuntu-trusty-64:/work/src/github.com/stackdocker/tomcat-docker/download/tomcat$ docker run -d -p 8080:8080 --name=tomcat7-jre8 tomcat:7-jre8
aed0ea601178fa0ae99b8a2a7da00315e81ecd5569c8c2108db65d60ec794809
vagrant@vagrant-ubuntu-trusty-64:/work/src/github.com/stackdocker/tomcat-docker/download/tomcat$ docker ps -f name=tomcat7-jre8
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                    NAMES
aed0ea601178        tomcat:7-jre8       "catalina.sh run"   46 seconds ago      Up 45 seconds       0.0.0.0:8080->8080/tcp   tomcat7-jre8
```

浏览Tomcat的内容，使用浏览器如http://<Linux的ip地址>:8080
```
vagrant@vagrant-ubuntu-trusty-64:/work/src/github.com/stackdocker/tomcat-docker/download/tomcat$ curl http://127.0.0.1:8080

<!DOCTYPE html>


<html lang="en">
    <head>
        <title>Apache Tomcat/7.0.77</title>
        <link href="favicon.ico" rel="icon" type="image/x-icon" />
        <link href="favicon.ico" rel="shortcut icon" type="image/x-icon" />
        <link href="tomcat.css" rel="stylesheet" type="text/css" />
    </head>

（body内容...）

</html>
```

了解容器内tomcat的目录
```
vagrant@vagrant-ubuntu-trusty-64:/work/src/github.com/stackdocker/tomcat-docker/download/tomcat$ docker exec -ti tomcat7-jre8 bash -c "pwd && ls"
/usr/local/tomcat
LICENSE  NOTICE  RELEASE-NOTES	RUNNING.txt  bin  conf	include  lib  logs  native-jni-lib  temp  webapps  work
```

复制sample.war到webapps下
```
vagrant@vagrant-ubuntu-trusty-64:/work/src/github.com/stackdocker/tomcat-docker/download/tomcat$ docker cp ./sample.war tomcat7-jre8:/usr/local/tomcat/webapps/
vagrant@vagrant-ubuntu-trusty-64:/work/src/github.com/stackdocker/tomcat-docker/download/tomcat$ docker exec -ti tomcat7-jre8 ls ./webapps
ROOT  docs  examples  host-manager  manager  sample  sample.war
```

浏览sample
```
vagrant@vagrant-ubuntu-trusty-64:/work/src/github.com/stackdocker/tomcat-docker/download/tomcat$ curl -L http://127.0.0.1:8080/sample
<html>
（内容...）
</html>
```

生成sample app容器
```
vagrant@vagrant-ubuntu-trusty-64:/work/src/github.com/stackdocker/tomcat-docker/download/tomcat$ docker commit -m "sample app" tomcat7-jre8 tangfeixiong/tomcat-sample
sha256:91bedf32c2c01a19197d3cc8d65173b5531a626ffaa1f082ac254f3a3808d8f7
vagrant@vagrant-ubuntu-trusty-64:/work/src/github.com/stackdocker/tomcat-docker/download/tomcat$ docker images tangfeixiong/tomcat-sample
REPOSITORY                   TAG                 IMAGE ID            CREATED             SIZE
tangfeixiong/tomcat-sample   latest              91bedf32c2c0        7 minutes ago       367.3 MB
```

卸载tomcat容器
```
vagrant@vagrant-ubuntu-trusty-64:/work/src/github.com/stackdocker/tomcat-docker/download/tomcat$ docker stop tomcat7-jre8 && docker rm tomcat7-jre8
tomcat7-jre8
tomcat7-jre8
```

创建tomcat-sample的容器（示例中172.17.4.200该演示Linux的ip地址）
```
vagrant@vagrant-ubuntu-trusty-64:/work/src/github.com/stackdocker/tomcat-docker/download/tomcat$ docker run -d -p 8080:8080 tangfeixiong/tomcat-sample
63e33e0978c5ff5f7f8ab163600d6f25e245b1ad3b2e02699d719824fd414977
vagrant@vagrant-ubuntu-trusty-64:/work/src/github.com/stackdocker/tomcat-docker/download/tomcat$ docker ps -f id=63e33e0978c5ff5f7f8ab163600d6f25e245b1ad3b2e02699d719824fd414977
CONTAINER ID        IMAGE                        COMMAND             CREATED             STATUS              PORTS                    NAMES
63e33e0978c5        tangfeixiong/tomcat-sample   "catalina.sh run"   2 minutes ago       Up 2 minutes        0.0.0.0:8080->8080/tcp   lonely_hamilton
vagrant@vagrant-ubuntu-trusty-64:/work/src/github.com/stackdocker/tomcat-docker/download/tomcat$ curl http://172.17.4.200:8080/sample/
<html>
<head>
<title>Sample "Hello, World" Application</title>
</head>
<body bgcolor=white>

<table border="0">
<tr>
<td>
<img src="images/tomcat.gif">
</td>
<td>
<h1>Sample "Hello, World" Application</h1>
<p>This is the home page for a sample application used to illustrate the
source directory organization of a web application utilizing the principles
outlined in the Application Developer's Guide.
</td>
</tr>
</table>

<p>To prove that they work, you can execute either of the following links:
<ul>
<li>To a <a href="hello.jsp">JSP page</a>.
<li>To a <a href="hello">servlet</a>.
</ul>

</body>
</html>
```

删除devops操作
```
vagrant@vagrant-ubuntu-trusty-64:/work/src/github.com/stackdocker/tomcat-docker/download/tomcat$ docker stop 63e33e0978c5ff5f7f8ab163600d6f25e245b1ad3b2e02699d719824fd414977 && docker rm 63e33e0978c5ff5f7f8ab163600d6f25e245b1ad3b2e02699d719824fd414977 && docker rmi tangfeixiong/tomcat-sample
63e33e0978c5ff5f7f8ab163600d6f25e245b1ad3b2e02699d719824fd414977
63e33e0978c5ff5f7f8ab163600d6f25e245b1ad3b2e02699d719824fd414977
Untagged: tangfeixiong/tomcat-sample:latest
Deleted: sha256:91bedf32c2c01a19197d3cc8d65173b5531a626ffaa1f082ac254f3a3808d8f7
Deleted: sha256:ffc8b87062bc6d2508e42c96422bf1ce2467b559fcff56ab23f15081bb89ee41
```

### 命令过程转换为Dockerfile

基本就是将命令写到Dockerfile，当然可以对Tomcat定制运行参数
```
vagrant@vagrant-ubuntu-trusty-64:/work/src/github.com/stackdocker/tomcat-docker/download/tomcat$ cat > Dockerfile << EOF
> FROM tomcat:8
> LABEL author="tangfeixiong<tangfx128@gmail.com" description="tomcat sample app"
> COPY sample.war /usr/local/tomcat/webapps/
> # VOLUME ["/usr/local/tomcat/webapps/sample"]
> EXPOSE 8080
> ENV CATALINA_OPTS "-Xms64M -Xmx256M -XX:PermSize=64m -XX:MaxPermSize=256m"
> EOF
vagrant@vagrant-ubuntu-trusty-64:/work/src/github.com/stackdocker/tomcat-docker/download/tomcat$ cat Dockerfile 
FROM tomcat:8
LABEL author="tangfeixiong<tangfx128@gmail.com" description="tomcat sample app"
COPY sample.war /usr/local/tomcat/webapps/
# VOLUME ["/usr/local/tomcat/webapps/sample"]
EXPOSE 8080
ENV CATALINA_OPTS "-Xms64M -Xmx256M -XX:PermSize=64m -XX:MaxPermSize=256m"
```

制作
```
vagrant@vagrant-ubuntu-trusty-64:/work/src/github.com/stackdocker/tomcat-docker/download/tomcat$ docker build -t tangfeixiong/tomcat-sample:0.1 -f ./Dockerfile .
Sending build context to Docker daemon 8.987 MB
Step 1 : FROM tomcat:8
 ---> 08f8166740f8
Step 2 : LABEL author "tangfeixiong<tangfx128@gmail.com" description "tomcat sample app"
 ---> Running in 8d7d442c3386
 ---> 4987a434b653
Removing intermediate container 8d7d442c3386
Step 3 : COPY sample.war /usr/local/tomcat/webapps/
 ---> 600c4958fb9a
Removing intermediate container e114a6b9e29c
Step 4 : EXPOSE 8080
 ---> Running in 46b331388585
 ---> 143152b59591
Removing intermediate container 46b331388585
Step 5 : ENV CATALINA_OPTS "-Xms64M -Xmx256M -XX:PermSize=64m -XX:MaxPermSize=256m"
 ---> Running in ac94697e48b1
 ---> 43930d8b8644
Removing intermediate container ac94697e48b1
Successfully built 43930d8b8644
vagrant@vagrant-ubuntu-trusty-64:/work/src/github.com/stackdocker/tomcat-docker/download/tomcat$ docker images -f label=author
REPOSITORY                   TAG                 IMAGE ID            CREATED              SIZE
tangfeixiong/tomcat-sample   0.1                 43930d8b8644        About a minute ago   366.7 MB
vagrant@vagrant-ubuntu-trusty-64:/work/src/github.com/stackdocker/tomcat-docker/download/tomcat$ docker run -d -p 8090:8080 tangfeixiong/tomcat-sample:0.1 && sleep 2s && curl -L localhost:8090/sample
661a71260fe4f509f969fe8eb6109e617abe6ab320778d43220df74606466967
<html>
<head>
<title>Sample "Hello, World" Application</title>
</head>
<body bgcolor=white>

<table border="0">
<tr>
<td>
<img src="images/tomcat.gif">
</td>
<td>
<h1>Sample "Hello, World" Application</h1>
<p>This is the home page for a sample application used to illustrate the
source directory organization of a web application utilizing the principles
outlined in the Application Developer's Guide.
</td>
</tr>
</table>

<p>To prove that they work, you can execute either of the following links:
<ul>
<li>To a <a href="hello.jsp">JSP page</a>.
<li>To a <a href="hello">servlet</a>.
</ul>

</body>
</html>

### Next

定制的Tomcat基础镜像，请参考[本仓库7.0.73目录内容](https://github.com/stackdocker/tomcat-docker/tree/master/7.0.73)

配置JavaEE，如JDBC的driver（如PostgreSQL），可以放在lib目录下，则Dockerfile如：
```
COPY ifxjdbc.jar ifxjdbcx.jar /usr/local/tomcat/lib/
```

配置webapp的上下文，如JDBC的connection，则Dockerfile如（未验证）：
```
COPY tc-pg-example.war /usr/local/tomcat/webapps/
RUN cd /usr/local/tomcat/webapps \
  && mkdir tc-pg-example \
  && cd tc-pg-example \
  && jar -xvf ../tc-pg-example.war \
  && cd .. \
  && rm tc-pg-example.war 
COPY context.xml /usr/local/tomcat/webapps/tc-pg-example/META-INF/
COPY ifxjdbc.jar ifxjdbcx.jar /usr/local/tomcat/webapps/tc-pg-example/WEB-INF/lib/
```

更多请参考[Tomcat webapp deployment](https://tomcat.apache.org/tomcat-8.5-doc/deployer-howto.html#A_word_on_Contexts)，和[Tomcat JDCC DataSources](https://tomcat.apache.org/tomcat-8.5-doc/deployer-howto.html#A_word_on_Contexts)

关于Docker build，请参考[reference](https://docs.docker.com/engine/reference/builder/)
