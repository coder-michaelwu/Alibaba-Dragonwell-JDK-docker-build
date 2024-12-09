FROM centos:centos7
LABEL org.opencontainers.image.authors="Michael Wu" 
 
# install timezone gcc
ENV ENVIRONMENT=DOCKER_PROD
RUN cd / && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
 
# cd /opt
WORKDIR /opt

# copy jdk8 to /opt, and decompression
ADD https://dragonwell.oss-cn-shanghai.aliyuncs.com/8.23.22/Alibaba_Dragonwell_Standard_8.23.22_x64_linux.tar.gz  /opt
RUN tar -zxvf Alibaba_Dragonwell_Standard_8.23.22_x64_linux.tar.gz && rm -fr Alibaba_Dragonwell_Standard_8.23.22_x64_linux.tar.gz
RUN curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo \
    &&  yum clean all && yum makecache \
    && yum -y install which

# set jdk8 env
ENV JAVA_HOME=/opt/dragonwell-8.23.22
ENV CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH=$JAVA_HOME/bin:$PATH

# exec java -version
CMD ["java","-version"]
