ARG VERSION
FROM docker.io/centos:7.4.1708


ARG YUM_FLAGS_COMMON="-q -y"
ARG PIP_FLAGS_COMMON="--no-cache-dir -i https://mirrors.aliyun.com/pypi/simple/ --extra-index-url http://192.168.239.230:8888/simple/  --trusted-host 192.168.239.230"
ARG OKP_HOME="/home/okp"
ARG PACKAGE_SERVER="http://192.168.238.112/packages"
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

RUN groupadd okp && \
    useradd okp -g okp -G okp && \
    echo 'export LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8' >> ${OKP_HOME}/.bash_profile

#ADD tmp/package /tmp/package
#COPY tmp/py_package/Python-3.6.5.tar.xz ${OKP_HOME}

RUN yum ${YUM_FLAGS_COMMON} install epel-release && \
    yum ${YUM_FLAGS_COMMON} install net-tools.x86_64 sysstat git supervisor gcc make zlib zlib-devel bzip2 bzip2-devel openssl mysql openssl-devel wget vim nc telnet \
        gcc-c++ \
        openssl098e \
        unixODBC \
        unixODBC-devel && \
#    yum ${YUM_FLAGS_COMMON} localinstall /tmp/package/nmap-7.70-1.x86_64.rpm && \
#    chmod u+s /usr/bin/nmap




RUN yum ${YUM_FLAGS_COMMON} install yum install \
          java \
          java-1.8.0-openjdk-devel 1>/dev/null && \
    yum ${YUM_FLAGS_COMMON} clean all && \
    rm -rf /var/cache/ldconfig/ && \
    rm -rf /var/cache/yum/ && \
    rm -rf /tmp/yum* && \
    rm -rf /tmp/package

ADD tmp/datetime.txt /app/
ADD tmp/start.sh /start.sh
ADD tmp/wait-for-it.sh /wait-for-it.sh
ARG VERSION
ARG GITAUTH

USER root

EXPOSE 8020/TCP
ENTRYPOINT ["/bin/bash"]
CMD ["/start.sh"]
