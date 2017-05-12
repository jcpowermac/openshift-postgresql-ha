FROM centos


ENV USER_NAME=default \
    USER_UID=10001 \
    HOME=/opt/app-root

COPY entrypoint.sh /usr/bin

RUN yum -y install epel-release && \
    yum -y install https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm && \
    yum -y install pgadmin4-v1-web python-passlib && \
    mkdir -p ${HOME}/etc /var/log/pgadmin4/ /var/lib/pgadmin4/sessions /var/lib/pgadmin4/storage && \
    chmod -R ug+x /usr/bin/entrypoint.sh && \
    useradd -l -u ${USER_UID} -r -g 0 -d ${HOME} -s /sbin/nologin -c "${USER_NAME} application user" ${USER_NAME} && \
    chown -R ${USER_UID}:0 ${HOME} && \
    chmod -R g+w ${HOME} /var/lib/pgadmin4 /var/log/pgadmin4 /etc/passwd


COPY config_local.py /usr/lib/python2.7/site-packages/pgadmin4-web/
#RUN python /usr/lib/python2.7/site-packages/pgadmin4-web/setup.py


RUN chown -R ${USER_UID}:0 /var/log/pgadmin4 /var/lib/pgadmin4
EXPOSE 5050


USER ${USER_UID}
RUN sed "s@${USER_NAME}:x:${USER_UID}:@${USER_NAME}:x:\${USER_ID}:@g" /etc/passwd > ${HOME}/etc/passwd.template

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["python", "/usr/lib/python2.7/site-packages/pgadmin4-web/pgAdmin4.py"]

