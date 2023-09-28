#!/bin/bash

# 部署监控对象
object=kafka
value_file="bitnami_values.yaml"

helm install $object-cluster-$version_suffix --namespace $object -f ./values/$value_file ./$object \
--set commonLabels.object_version=$version_suffix \
--set service.nodePorts.mongodb=$port




