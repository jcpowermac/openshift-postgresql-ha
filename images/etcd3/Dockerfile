FROM centos

RUN INSTALL_PKGS="etcd" && \
    yum install -y $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all && \
    mkdir -p /var/run/etcd/ && \
    chown -R 1001:0 /var/run/etcd/ && \
    chmod -R u+g /var/run/etcd/

USER 1001

ENTRYPOINT ["/usr/bin/etcd"]
