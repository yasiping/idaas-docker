ARG VERSION
FROM idaas-base:${VERSION}

RUN yum -q -y install yum install java java-1.8.0-openjdk-devel
#           && \
#    yum ${YUM_FLAGS_COMMON} clean all && \
#    rm -rf /var/cache/ldconfig/ && \
#    rm -rf /var/cache/yum/ && \
#    rm -rf /tmp/yum* && \
#    rm -rf /tmp/package

ADD tmp/datetime.txt /app/
ADD tmp/start.sh /start.sh
ADD tmp/wait-for-it.sh /wait-for-it.sh
ARG VERSION
ARG GITAUTH

USER root

EXPOSE 8020/TCP
ENTRYPOINT ["/bin/bash"]
CMD ["/start.sh"]
