#!/usr/bin/env bash


cluster_name=$( kubectl get cm kubescape-config -n kubescape -o json | jq '.data."config.json" | fromjson | .clusterName' )
account_ID=$( kubectl get cm kubescape-config -n kubescape -o json | jq '.data."config.json" | fromjson | .accountID' )

echo "Cluster name is: ${cluster_name}"
echo "Account ID is: ${account_ID}"


helm repo add kubescape https://kubescape.github.io/helm-charts/
helm repo update

upgrade_command="helm upgrade --install kubescape kubescape/kubescape-operator -n kubescape --create-namespace --set clusterName=${cluster_name} --set account=${account_ID} --set server=api.armosec.io"
eval ${upgrade_command}
