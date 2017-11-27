FROM centos
MAINTAINER xiangzi <wenzhengxiang@ubao123.com>

RUN yum install -y epel-release \
 && yum update -y \
 && yum install -y wget gcc make apr apr-devel openssl openssl-devel

ENV TOMCAT_MAJOR_VERSION=7 \
    TOMCAT_VERSION=7.0.82 \
    CATALINA_HOME=/opt/tomcat \
    JAVA_VERSION=7 \
    JAVA_UPDATE=80 \
    JAVA_BUILD=15 \
    JAVA_HOME=/opt/jdk \
    JRE_HOME=/opt/jdk/jre \
    LANG=en_US.UTF-8 \
    LD_LIBRARY_PATH=:/usr/local/apr/lib \
    JAVA_OPTS="-server -Xms1200m -Xmx1200m -Xss512k -XX:PermSize=128M -XX:MaxPermSize=256m -Djava.awt.headless=true"

RUN wget -q http://apitest.healthlink.cn:9000/server-jre-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz -O /tmp/server-jre.tar.gz \
 && tar -zxf /tmp/server-jre.tar.gz -C /opt/ \
 && mv /opt/jdk1.$JAVA_VERSION.0_$JAVA_UPDATE $JAVA_HOME \
 && wget -q https://mirrors.cnnic.cn/apache/tomcat/tomcat-$TOMCAT_MAJOR_VERSION/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz -O /tmp/tomcat.tar.gz \
 && tar -zxf /tmp/tomcat.tar.gz -C /opt/ \
 && mv /opt/apache-tomcat-$TOMCAT_VERSION $CATALINA_HOME \
 && rm -rf $CATALINA_HOME/webapps/* $JAVA_HOME/src.zip \
 && sed -i 's/securerandom\.source=file:\/dev\/urandom/securerandom\.source=file:\/dev\/\.\/urandom/' $JRE_HOME/lib/security/java.security \
 && tar -zxf $CATALINA_HOME/bin/tomcat-native.tar.gz -C /tmp \
 && cd /tmp/tomcat-native-1.2.14-src/native/ \
 && ./configure \
 && make \
 && make install \
 && rpm -e --nodeps wget gcc make \
 && chown -R nobody:nobody $CATALINA_HOME \
 && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
 && yum clean all \
 && rm -rf /tmp/* /var/tmp/* /var/cache/yum/*

EXPOSE 8080

WORKDIR $CATALINA_HOME
USER nobody
CMD ["bin/catalina.sh","run"]
