FROM docker.io/centos:7.4.1708

ARG YUM_FLAGS_COMMON="-q -y"
ARG PIP_FLAGS_COMMON="--no-cache-dir -i https://mirrors.aliyun.com/pypi/simple/ --extra-index-url http://192.168.239.230:8888/simple/  --trusted-host 192.168.239.230"
ARG OKP_HOME="/home/okp"
ARG PACKAGE_SERVER="http://192.168.238.112/packages"
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8
ENV PYENV_ROOT /home/okp/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
ENV IBM_DB_HOME /home/okp/ibm_db-3.0.1/clidriver
ENV LD_LIBRARY_PATH /home/okp/ibm_db-3.0.1/clidriver/lib:$LD_LIBRARY_PATH

RUN groupadd okp && \
    useradd okp -g okp -G okp && \
    echo 'export LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8' >> ${OKP_HOME}/.bash_profile

ADD tmp/package /tmp/package
ADD tmp/py_package/pyenv-1.2.15.tar.gz ${OKP_HOME}
ADD tmp/py_package/pyenv-virtualenv-1.1.5.tar.gz ${OKP_HOME}
COPY tmp/py_package/Python-3.6.5.tar.xz ${OKP_HOME}
COPY tmp/py_package/ibm_db-3.0.1.tar.gz ${OKP_HOME}
COPY tmp/py_package/linuxx64_odbc_cli.tar.gz ${OKP_HOME}

RUN yum ${YUM_FLAGS_COMMON} install epel-release && \
    yum ${YUM_FLAGS_COMMON} install net-tools.x86_64 sysstat git supervisor gcc make zlib zlib-devel bzip2 bzip2-devel openssl mysql openssl-devel wget vim nc telnet \
        gcc-c++ \
        openssl098e \
        unixODBC \
        unixODBC-devel && \
    yum ${YUM_FLAGS_COMMON} localinstall /tmp/package/oracle-instantclient18.5-basic-18.5.0.0.0-3.x86_64.rpm && \
    sh -c "echo /usr/lib/oracle/18.5/client64/lib > /etc/ld.so.conf.d/oracle-instantclient.conf" && \
    curl ${PACKAGE_SERVER}/dm-7.1-x86_64.tar.gz | tar -zx -C /usr/local/lib64 && \
    echo 'export LD_LIBRARY_PATH="/usr/local/lib64/dm:$LD_LIBRARY_PATH"' >> ${OKP_HOME}/.bash_profile && \
    curl ${PACKAGE_SERVER}/KingbaseES_8_ODBC_Driver_for_Linux.tar.gz | tar -zx -C /usr/local/lib64 && \
    curl ${PACKAGE_SERVER}/KingbaseES_8_ODBC_Driver_for_Linux.odbcinst | odbcinst -i -d -r && \
    curl ${PACKAGE_SERVER}/InterSystems_Cache_Python_Driver_for_Linux.tar.gz  | tar -zx -C /usr/local/lib64 && \
    yum ${YUM_FLAGS_COMMON} localinstall /tmp/package/nmap-7.70-1.x86_64.rpm && \
    chmod u+s /usr/bin/nmap && \    
    mv ${OKP_HOME}/pyenv-1.2.15 ${OKP_HOME}/.pyenv && \
    mkdir -p ${OKP_HOME}/.pyenv/plugins && \
    mv ${OKP_HOME}/pyenv-virtualenv-1.1.5 ${OKP_HOME}/.pyenv/plugins/pyenv-virtualenv && \
    mkdir -p ${OKP_HOME}/.pyenv/cache && \
    mv ${OKP_HOME}/Python-3.6.5.tar.xz ${OKP_HOME}/.pyenv/cache/ && \
    tar zxf ${OKP_HOME}/ibm_db-3.0.1.tar.gz -C ${OKP_HOME} && \
    tar zxf ${OKP_HOME}/linuxx64_odbc_cli.tar.gz -C  ${OKP_HOME}/ibm_db-3.0.1 && \
    ln -s /home/okp/ibm_db-3.0.1/clidriver/lib/libdb2.so.1 /usr/lib && \
    mkdir /app  && \
    ldconfig && \
    chown okp:okp /app  && \
    echo 'export IBM_DB_HOME=/home/okp/ibm_db-3.0.1/clidriver' >> ${OKP_HOME}/.bash_profile && \
    echo 'export LD_LIBRARY_PATH=$IBM_DB_HOME/lib:$LD_LIBRARY_PATH' >> ${OKP_HOME}/.bash_profile && \    
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ${OKP_HOME}/.bash_profile && \
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ${OKP_HOME}/.bash_profile && \
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ${OKP_HOME}/.bash_profile && \
    echo 'eval "$(pyenv virtualenv-init -)"' >> ${OKP_HOME}/.bash_profile && \
    echo 'eval "$(pyenv init -)"' >> ${OKP_HOME}/.bash_profile && \
    pyenv install 3.6.5 && \
    pyenv virtualenv 3.6.5 okp-collector && \
    pyenv virtualenv 3.6.5 drcc-backend-env && \
    chown -R okp:okp ${OKP_HOME} && \
    # 仅在安装pyodbc时需要gcc-c++ unixODBC-devel, 安装后可移除. 结构原因暂时保留.
    # yum ${YUM_FLAGS_COMMON} remove gcc-c++ unixODBC-devel && \
    yum ${YUM_FLAGS_COMMON} remove epel-release && \
    yum ${YUM_FLAGS_COMMON} autoremove && \
    yum ${YUM_FLAGS_COMMON} clean all && \
    rm -rf /var/cache/ldconfig/ && \
    rm -rf /var/cache/yum/ && \
    rm -rf /tmp/yum* && \
    rm -rf /tmp/package

ADD tmp/wait-for-it.sh /
ADD tmp/tnsping.tar.gz /

ENTRYPOINT ["/bin/bash"]