#!/bin/bash

KUBECONFIG="/Users/mzc01-jackchun/.kube/config"

while IFS= read -r line; 
do
  kubectl --kubeconfig=$KUBECONFIG delete crd $line
done < crd_list.txt

