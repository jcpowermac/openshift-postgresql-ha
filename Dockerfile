FROM centos/postgresql-95-centos7

USER root

RUN yum install -y epel-release && \
    yum install -y etcd gcc make ansible python-pip iproute
    
#yum install -y openssl etcd stunnel supervisor.noarch rh-python35 gcc make rh-postgresql95-postgresql-devel rh-python35-python-devel ansible 

# Install patroni and WAL-e
ENV PATRONIVERSION=1.2.4
ENV WALE_VERSION=1.0.3
ENV PGHOME=/var/lib/pgsql/
ENV PGROOT=$PGHOME/pgdata/pgroot
ENV PGDATA=$PGROOT/data
ENV PGLOG=$PGROOT/pg_log
ENV WALE_ENV_DIR=$PGHOME/etc/wal-e.d/env
ENV USER_NAME=${PGUSER}
ENV USER_UID=26
#ENV ENABLED_COLLECTIONS="rh-postgresql95 rh-python35"
#RUN export DEBIAN_FRONTEND=noninteractive \
#    export BUILD_PACKAGES="python3-pip" \
#    && apt-get update \
#    && apt-get install -y \
#            # Required for wal-e
#            daemontools lzop \
#            # Required for /usr/local/bin/patroni
#            python3 python3-setuptools python3-pystache python3-prettytable python3-six \
#            ${BUILD_PACKAGES} \


RUN pip install pip --upgrade && \
    pip install --upgrade patroni==$PATRONIVERSION


#RUN pip3 install pip --upgrade \
#RUN scl enable rh-python35 -- easy_install pip \
#    && scl enable rh-python35 -- pip3 install --upgrade patroni==$PATRONIVERSION \ 
#    && scl enable rh-python35 -- pip3 install pystache 
#            gcloud boto wal-e==$WALE_VERSION \

    # https://github.com/wal-e/wal-e/issues/318
#    && sed -i 's/^\(    for i in range(0,\) num_retries):.*/\1 100):/g' /usr/local/lib/python3.5/dist-packages/boto/utils.py \


# install etcdctl
#ENV ETCDVERSION 2.3.8
#RUN curl -L https://github.com/coreos/etcd/releases/download/v${ETCDVERSION}/etcd-v${ETCDVERSION}-linux-amd64.tar.gz \
#    | tar xz -C /bin --strip=1 --wildcards --no-anchored etcdctl etcd


#install pg_view
#RUN curl -L https://raw.githubusercontent.com/zalando/pg_view/2ea99479460d81361bdb7601a1564072ddd584ac/pg_view.py \
#    | sed -e 's/env python/env python3/g' > /usr/local/bin/pg_view.py && chmod +x /usr/local/bin/pg_view.py


RUN mv /opt/rh/rh-postgresql95/root/usr/bin/postgres{,-real} && \
    cp /opt/rh/rh-postgresql95/enable /opt/rh/rh-postgresql95/root/usr/bin/postgres && \
    echo 'exec postgres-real "$@"' >> /opt/rh/rh-postgresql95/root/usr/bin/postgres && \
    chmod 755 /opt/rh/rh-postgresql95/root/usr/bin/postgres

ADD root /

RUN chmod -R ug+x /usr/bin/user_setup && \
    /usr/bin/user_setup

# Set PGHOME as a login directory for the PostgreSQL user.
#RUN usermod -d $PGHOME -m postgres

#ADD configure_spilo.py launch.sh postgres_backup.sh patroni_wait.sh post_init.sh _zmon_schema.dump callback_role.py basebackup.sh wale_restore_command.sh /
#ADD supervisor.d /etc/supervisord.d/
#ADD pgq_ticker.ini $PGHOME
#ADD motd /etc/
#RUN echo "source /etc/motd" >> /root/.bashrc
#RUN echo "export TERM=linux\nexport LC_ALL=C.UTF-8\nexport LANG=C.UTF-8" >> /etc/bash.bashrc
#RUN chmod 700 /postgres_*
ADD entrypoint.yml /var/lib/pgsql/
ADD templates /var/lib/pgsql/templates
#ADD run-postgresql /usr/bin

USER ${USER_UID}
RUN sed "s@${USER_NAME}:x:${USER_UID}:@${USER_NAME}:x:\${USER_ID}:@g" /etc/passwd > ${HOME}/passwd.template
WORKDIR $PGHOME
EXPOSE 5432 8008




