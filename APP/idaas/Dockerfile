FROM docker.io/centos:7.4.1708

ARG VERSION

ARG YUM_FLAGS_COMMON="-q -y"
ARG CAPAA_HOME="/home/capaa"

RUN groupadd capaa && \
    useradd capaa -g capaa -G capaa && \
    echo 'export LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8' >> ${CAPAA_HOME}/.bash_profile

RUN yum ${YUM_FLAGS_COMMON} install yum install java \
          java-1.8.0-openjdk-devel 1>/dev/null && \
    yum ${YUM_FLAGS_COMMON} install net-tools.x86_64 sysstat git supervisor gcc make zlib zlib-devel bzip2 bzip2-devel openssl mysql openssl-devel wget vim nc telnet \
        gcc-c++ \
        openssl098e \
        unixODBC \
        unixODBC-devel && \
    yum ${YUM_FLAGS_COMMON} clean all && \
    rm -rf /var/cache/ldconfig/ && \
    rm -rf /var/cache/yum/ && \
    rm -rf /tmp/yum* && \
    rm -rf /tmp/package

ADD tmp/datetime.txt /app/
ADD tmp/application.yml  /application.yml
ADD tmp/start.sh /start.sh
ADD tmp/wait-for-it.sh /wait-for-it.sh
ARG VERSION
ARG GITAUTH

USER root

EXPOSE 8020/TCP
ENTRYPOINT ["/bin/bash"]
CMD ["/start.sh"]
