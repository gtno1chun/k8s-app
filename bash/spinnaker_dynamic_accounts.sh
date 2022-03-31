#!/bin/bash
## DELETE_OUTPUT
function delete_out() {
  rm $PWD/del_list_kubectl
  rm $PWD/kubeconfig*
  rm $PWD/config*
}
delete_out

KUBECONFIG_FILE=$HOME/.kube/config

if [ ! -f $PWD/config ]; then
  cp -f $KUBECONFIG_FILE $PWD/.
fi


## VARIABLE 
function config_variable() {
  get_contexts=`kubectl config get-contexts | wc -l`
  count_cluster=$( seq 1 $(expr $get_contexts - 1) )
}


## CREATE k8s config
function create_k8s_config() {
  config_variable

  for i in $count_cluster
  do
    cluster_name=$( kubectl config view --kubeconfig=config -o jsonpath='{.contexts[*].name}' | awk -F" " '{print $ct}' ct="$i" )
    k8s_configs=$( kubectl config view --kubeconfig=config -o jsonpath='{.contexts[*].name}' | awk -F" " '{print $ct}' ct="$i" | awk -F"/" '{print $2}' ) 
    cp $PWD/config $PWD/config_$k8s_configs

    for j in $count_cluster
    do
      cluster_check=$( kubectl config view --kubeconfig=config_$k8s_configs -o jsonpath='{.contexts[*].name}' | awk -F" " '{print $ct}' ct="$j"  | awk -F"/" '{print $2}' )
      delete_cluster_name=$( kubectl config view --kubeconfig=config_$k8s_configs -o jsonpath='{.contexts[*].name}' | awk -F" " '{print $ct}' ct="$j" )
      #echo "config_$k8s_configs"
      if [ $k8s_configs != $cluster_check ]; then
        echo "kubectl config delete-cluster --kubeconfig=config_$k8s_configs $delete_cluster_name" >> $PWD/del_list_kubectl
        echo "kubectl config delete-context --kubeconfig=config_$k8s_configs $delete_cluster_name" >> $PWD/del_list_kubectl
        echo "kubectl config delete-user --kubeconfig=config_$k8s_configs $delete_cluster_name" >> $PWD/del_list_kubectl
      fi

    done

  done

  while read -r line;
  do
    echo `$line`;
  done < $PWD/del_list_kubectl

}
create_k8s_config

## CRATE kubeconfig_[$name].yml
function create_kubeconfig_json() {
  config_variable
  cat << EOF > $PWD/kubeconfig_all_clusters.yml
kubernetes:
  enabled: true
  accounts: 
EOF

  for i in $count_cluster
  do
    #cluster_name=$( kubectl config view --kubeconfig=config -o jsonpath='{.contexts[*].name}' | awk -F" " '{print $ct}' ct="$i" )
    k8s_configs=$( kubectl config view --kubeconfig=config -o jsonpath='{.contexts[*].name}' | awk -F" " '{print $ct}' ct="$i" | awk -F"/" '{print $2}' )
    echo $k8s_configs
    kubeconfig=$( cat $PWD/config_$k8s_configs | sed -E ':a;N;$!ba;s/\r{0,1}\n/\\n/g' )

    cat << EOF >> $PWD/kubeconfig_all_clusters.yml
  - name: $k8s_configs
    requiredGroupMembership: []
    providerVersion: V2
    permissions: {}
    dockerRegistries: []
    configureImagePullSecrets: true
    cacheThreads: 1
    namespaces: []
    omitNamespaces: []
    kinds: []
    omitKinds: []
    customResources: []
    cachingPolicies: []
    kubeconfigContents: "$kubeconfig"
EOF
  done
  

  if [ -f "$PWD/kubeconfig_all_clusters.yml" ]; then 
    echo "exist kubeconfig_all_clusters.yml"
    yq $PWD/kubeconfig_all_clusters.yml -o=json > $PWD/kubeconfig.json
  else
    echo "does not have kubeconfig YAML"
  fi

}
create_kubeconfig_json

function vault_put() {
  config_variable
  k8s_configs=$( kubectl config view --kubeconfig=config -o jsonpath='{.contexts[*].name}' | awk -F" " '{print $ct}' ct="$i" | awk -F"/" '{print $2}' ) 

  # export VAULT_ADDR='http://15.165.41.118:10200'

  vault login jackchun-token
  ##test
  vault kv list spinnaker
  ##VAULT PUT
  sleep 1
  vault kv put spinnaker/clouddriver @$PWD/kubeconfig.json

 for i in $count_cluster
  do
    cluster_name=$( kubectl config view --kubeconfig=config -o jsonpath='{.contexts[*].name}' | awk -F" " '{print $ct}' ct="$i" )
    k8s_configs=$( kubectl config view --kubeconfig=config -o jsonpath='{.contexts[*].name}' | awk -F" " '{print $ct}' ct="$i" | awk -F"/" '{print $2}' )

    vault kv put spinnaker/k8configs/$cluster_name kubeconfig=@config_$k8s_configs
  done

}
vault_put


