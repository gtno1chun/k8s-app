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

TOKEN="eyJhbGciOiJSUzI1NiIsImtpZCI6Inh2ZmJjUG1fR0NWWjVQNkhqc3hXbUstTDhsSlRuc1piSzZEZmw3ekdaTUEifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJzcGlubmFrZXIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlY3JldC5uYW1lIjoic3Bpbm5ha2VyLXNlcnZpY2UtYWNjb3VudC10b2tlbi13bnFscCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJzcGlubmFrZXItc2VydmljZS1hY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiOGJhNzAxNzAtNmJjYi00OGRkLTgxNzMtNDE0YjRkOWI2MmY5Iiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50OnNwaW5uYWtlcjpzcGlubmFrZXItc2VydmljZS1hY2NvdW50In0.V1kQlLyL2N1g0PSGnICNnhi2iifxBV5EHO2-M05h1M3gQmh4-WgotGn2_vGd58Cr86Rtib39rUZyRrsNhT7OGjoMUZielzOvHl0DsOKerS2evzxkk6XgefAXoh-foH83AU1WNhUjC7q0k68GnHXiT_FcWcLHsl9tc9tGVZrywb4UPBBd5zt3ROmHvV9Sp7KAHqV3UiDAvTiY1GoWfM-bCq0tPg-NlZoBg3Cee8mPGT9WjfpmEFdJhGarMGwJ7rx4EyDFBQnBZsyRAkUTOJ1TFnYcRGRN2LE91vFGL_mfPcFJLJcEhOA7GZqnxD02Ck3y2oQB_OD4B9jZoVziN3FsZA"


## VARIABLE 
function config_variable() {
  get_contexts=`kubectl config get-contexts | wc -l`
  count_cluster=$( seq 1 $(expr $get_contexts - 1) )
}


## Apply Secret Token
function apply_secret_token() {
  # EXIT_CODE=0


  #SECRET=$(kubectl --kubeconfig=config -n spinnaker get serviceaccount spinnaker-service-account -o jsonpath='{.secrets[0].name}')
  #TOKEN=$(kubectl --kubeconfig=config -n spinnaker get secret $SECRET -o jsonpath='{.data.token}' | base64 --decode)
  TOKEN="eyJhbGciOiJSUzI1NiIsImtpZCI6Inh2ZmJjUG1fR0NWWjVQNkhqc3hXbUstTDhsSlRuc1piSzZEZmw3ekdaTUEifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJzcGlubmFrZXIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlY3JldC5uYW1lIjoic3Bpbm5ha2VyLXNlcnZpY2UtYWNjb3VudC10b2tlbi13bnFscCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJzcGlubmFrZXItc2VydmljZS1hY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiOGJhNzAxNzAtNmJjYi00OGRkLTgxNzMtNDE0YjRkOWI2MmY5Iiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50OnNwaW5uYWtlcjpzcGlubmFrZXItc2VydmljZS1hY2NvdW50In0.V1kQlLyL2N1g0PSGnICNnhi2iifxBV5EHO2-M05h1M3gQmh4-WgotGn2_vGd58Cr86Rtib39rUZyRrsNhT7OGjoMUZielzOvHl0DsOKerS2evzxkk6XgefAXoh-foH83AU1WNhUjC7q0k68GnHXiT_FcWcLHsl9tc9tGVZrywb4UPBBd5zt3ROmHvV9Sp7KAHqV3UiDAvTiY1GoWfM-bCq0tPg-NlZoBg3Cee8mPGT9WjfpmEFdJhGarMGwJ7rx4EyDFBQnBZsyRAkUTOJ1TFnYcRGRN2LE91vFGL_mfPcFJLJcEhOA7GZqnxD02Ck3y2oQB_OD4B9jZoVziN3FsZA"

  for i in $count_cluster
  do
    cluster_name=$( kubectl config view --kubeconfig=config -o jsonpath='{.contexts[*].name}' | awk -F" " '{print $ct}' ct="$i" )
    k8s_configs=$( kubectl config view --kubeconfig=config -o jsonpath='{.contexts[*].name}' | awk -F" " '{print $ct}' ct="$i" | awk -F"/" '{print $2}' )
    kubectl --kubeconfig=config config set-credentials $cluster_name-token-user --token $TOKEN
    kubectl --kubeconfig=config config set-context $cluster_name --user $cluster_name-token-user
  done


}
apply_secret_token


## CREATE k8s config
function create_k8s_config() {
  config_variable

  for i in $count_cluster
  do
    cluster_name=$( kubectl config view --kubeconfig=config -o jsonpath='{.contexts[*].name}' | awk -F" " '{print $ct}' ct="$i" )
    k8s_configs=$( kubectl config view --kubeconfig=config -o jsonpath='{.contexts[*].name}' | awk -F" " '{print $ct}' ct="$i" | awk -F"/" '{print $2}' ) 
    cp $PWD/config $PWD/config_$k8s_configs
    kubectl --kubeconfig=config_$k8s_configs config set-credentials $cluster_name-token-user --token $TOKEN
    kubectl --kubeconfig=config_$k8s_configs config set-context $cluster_name --user ${cluster_name}-token-user
    

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
    #echo $k8s_configs
    
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

  # export VAULT_ADDR='http://15.165.41.118:10200'
  vault login jackchun-token
  ##test
  vault kv list spinnaker
  ##VAULT PUT
  sleep 1
  vault kv put spinnaker/clouddriver @$PWD/kubeconfig.json

 for i in $count_cluster
  do
    k8s_configs=$( kubectl config view --kubeconfig=config -o jsonpath='{.contexts[*].name}' | awk -F" " '{print $ct}' ct="$i" | awk -F"/" '{print $2}' ) 
    vault kv put spinnaker/k8configs/$k8s_configs kubeconfig=@config_$k8s_configs
  done

}
vault_put


