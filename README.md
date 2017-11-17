## Tomcat7
以 CentOS7:latest 为基础镜像，安装 JDK1.7.0_80 和 Tomcat7.0.82，部署 JAVA 环境

时区：中国-上海

语言：en_US.UTF-8

Tomcat 默认字符集：UTF-8

Tomcat 安装目录：/opt/apache-tomcat-7.0.82

JDK 安装目录：/opt/jdk1.7.0_80

且该镜像整合了自带的 tomcat-native，并以普通用户 “tomcat” 运行

**使用方法：**
```
docker run -d --name tomcat7 -p 8080:8080 -v ~/ROOT:/opt/apache-tomcat-7.0.82/webapps/ROOT wzx187202822/tomcat7
-d：后台运行
--name：容器命名为tomcat7
-p：容器8080端口映射到宿主机8080端口
-v：宿主机目录~/ROOT映射到容器目录/opt/apache-tomcat-7.0.82/webapps/ROOT
```
**环境变量：**
```
JAVA_HOME=/opt/jdk1.7.0_80
JRE_HOME=$JAVA_HOME/jre
CATALINA_HOME=/opt/apache-tomcat-7.0.82
PATH=$PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin
CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/apr/lib
JAVA_OPTS="-server -Xms1024m -Xmx1024m -Xss512K -XX:PermSize=128m -XX:MaxPermSize=256m -Djava.awt.headless=true"
```
