#!/bin/bash 

oc rollout pause deploymentconfig psql-ha-poc
oc scale --replicas 0 dc/psql-ha-poc
oc exec example-etcd-cluster-0000 -it -- etcdctl rm -r /service
oc start-build psql-ha-poc --follow
oc rollout resume deploymentconfig psql-ha-poc
oc rollout latest dc/psql-ha-poc
oc scale --replicas 3 dc/psql-ha-poc
