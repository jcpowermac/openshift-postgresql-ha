#!/bin/bash 

oc rollout pause deploymentconfig postgresql 
oc scale --replicas 0 dc/postgresql
oc exec example-etcd-cluster-0000 -it -- etcdctl rm -r /service
oc start-build postgresql --follow
oc rollout resume deploymentconfig postgresql
oc rollout latest dc/postgresql
oc scale --replicas 3 dc/postgresql
