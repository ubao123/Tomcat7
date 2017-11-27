FROM centos
MAINTAINER xiangzi <wenzhengxiang@ubao123.com>

RUN yum install -y epel-release \
 && yum update -y \
 && yum install -y wget gcc make apr apr-devel openssl openssl-devel

ENV TOMCAT_VERSION=7.0.82 \
    TOMCAT_MAJOR_VERSION=7 \
    JAVA_VERSION=7 \
    JAVA_UPDATE=80 \
    JAVA_BUILD=15 \
    LANG=en_US.UTF-8 \
    JAVA_OPTS="-server -Xms1024m -Xmx1024m -Xss512K -XX:PermSize=128m -XX:MaxPermSize=256m -Djava.awt.headless=tru"    

ENV TOMCAT_TGZ_URL=https://mirrors.cnnic.cn/apache/tomcat/tomcat-$TOMCAT_MAJOR_VERSION/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz
ENV JAVA_HOME=/opt/jdk1.$JAVA_VERSION.0_$JAVA_UPDATE
ENV JRE_HOME=$JAVA_HOME/jre
ENV CATALINA_HOME=/opt/apache-tomcat-$TOMCAT_VERSION
ENV PATH=$PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin
ENV CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/apr/lib

RUN wget -q http://apitest.healthlink.cn:9000/server-jre-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz -O /tmp/server-jre.tar.gz \
 && tar -zxf /tmp/server-jre.tar.gz -C /opt/ \
 && wget -q $TOMCAT_TGZ_URL -O /tmp/tomcat.tar.gz \
 && tar -zxf /tmp/tomcat.tar.gz -C /opt/ \
 && rm -rf $CATALINA_HOME/webapps/* $JAVA_HOME/src.zip \
 && sed -i 's/securerandom\.source=file:\/dev\/urandom/securerandom\.source=file:\/dev\/\.\/urandom/' $JRE_HOME/lib/security/java.security \
 && tar -zxf $CATALINA_HOME/bin/tomcat-native.tar.gz -C /tmp \
 && cd /tmp/tomcat-native-1.2.14-src/native/ \
 && ./configure \
 && make \
 && make install \
 && rpm -e --nodeps wget gcc make \
 && yum clean all \
 && rm -rf /tmp/* /var/tmp/* /var/cache/yum/* \
 && useradd -Ms /bin/false tomcat \
 && chown -R tomcat:tomcat $CATALINA_HOME \
 && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

EXPOSE 8080

WORKDIR $CATALINA_HOME
USER tomcat
CMD ["catalina.sh","run"]
