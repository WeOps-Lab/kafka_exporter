#!/bin/bash

# 删除监控对象
object=kafka

# 删除 k8s部署
echo "Uninstalling $object releases ..."

kubectl delete statefulset -n $object --all
kubectl delete svc -n $object --all
