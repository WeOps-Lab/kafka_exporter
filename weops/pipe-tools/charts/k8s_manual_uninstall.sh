#!/bin/bash

# 删除监控对象
object=kafka

# 删除 k8s部署
echo "Uninstalling $object releases ..."

kubectl delete statefulset -n $object --all
kubectl delete deployment -n $object --all
kubectl delete svc -n $object --all

# 删除 Helm chart
echo "Uninstalling $object releases ..."
for RELEASE in $(helm list -n $object --short)
do
  helm uninstall -n $object $RELEASE
done