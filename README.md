### PostgreSQL HA
Updates will follow...
Run PostgreSQL HA with Patroni on OpenShift.  Use either OpenShift template or Ansible Playbook Bundle (apb)

#### Ansible Playbook Bundle

```
sudo docker run --dns 10.53.252.123 --rm -it \
-e "OPENSHIFT_TARGET=openshift.virtomation.com:8443" \
-e "OPENSHIFT_USER=jcallen" -e "OPENSHIFT_PASS=" \
-e "postgresql_user=psqluser" \
-e "postgresql_postgres_password=password" \
-e "postgresql_admin_password=password" \
-e "postgresql_password=password" \
-e "postgresql_rep_user=repuser" \
-e "postgresql_rep_password=password" \
-e "postgresql_database=sampledb" \
jcpowermac/postgresql-ha-ansibleapp provision
```

