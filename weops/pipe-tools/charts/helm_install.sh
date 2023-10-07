#!/bin/bash

# 部署监控对象
object=kafka
value_file="bitnami_values.yaml"

helm install $object-cluster-v3-5 --namespace $object -f ./values/$value_file ./$object




