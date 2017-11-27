## CentOS7+JDK7+Tomcat7
以 CentOS7:latest 为基础镜像，安装 JDK1.7.0_80 和 Tomcat7.0.82，部署 java_web 环境

时区：中国-上海

语言：en_US.UTF-8

Tomcat 默认字符集：UTF-8

Tomcat 安装目录：/opt/tomcat

JDK 安装目录：/opt/jdk

且该镜像整合了自带的 tomcat-native，并以普通用户 “tomcat” 运行

**使用方法：**

```
docker run -d --name tomcat7 -p 8080:8080 -v ~/ROOT:/opt/tomcat/webapps/ROOT ubao123/tomcat7

-d：后台运行
--name：容器命名为tomcat7
-p：容器8080端口映射到宿主机8080端口
-v：宿主机目录~/ROOT映射到容器目录/opt/tomca/webapps/ROOT
```

**详细请看Dockerfile文件**
