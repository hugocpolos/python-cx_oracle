FROM python:3.7-slim
MAINTAINER Hugo Constantinopolos <hugo.cpolos@gmail.com>
WORKDIR /opt/data

# Add Files
ADD ./oracle-instantclient/ /opt/data
ADD ./install-instantclient.sh /opt/data

# Env vars
ENV ORACLE_HOME=/opt/oracle/instantclient
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME
ENV OCI_HOME=/opt/oracle/instantclient
ENV OCI_LIB_DIR=/opt/oracle/instantclient
ENV OCI_INCLUDE_DIR=/opt/oracle/instantclient/sdk/include
ENV NLS_LANG=AMERICAN_AMERICA.AL32UTF8

# INSTALL TOOLS
RUN apt-get update \
	&& apt-get -y install \
	unzip \
	gcc \
	libaio-dev \
	libpq-dev \
	python3-dev \
	&& mkdir -p /opt/data/api \
	&& chmod 755 install-instantclient.sh \
	&& ./install-instantclient.sh \
	&& pip install \
	cx_Oracle==5.3 \
	&& apt-get clean && apt-get autoclean \
	&& apt-get autoremove && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

