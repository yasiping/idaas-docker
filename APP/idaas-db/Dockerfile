FROM docker.io/library/mysql:5.7.27

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf