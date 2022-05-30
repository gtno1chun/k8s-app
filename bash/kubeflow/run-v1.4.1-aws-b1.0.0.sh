#!/bin/bash

BASE_DIR=$HOME/Projects/kubeflow
KF_home=$BASE_DIR/kubeflow-manifests
KF_common=$BASE_DIR/kubeflow-manifests/upstream/common
KF_apps=$BASE_DIR/kubeflow-manifests/upstream/apps

KF_manifest=$BASE_DIR/kubeflow-manifests/upstream

if [ ! -d $BASE_DIR ]; then
  mkdir -p $BASE_DIR
fi


KUBECONFIG=$HOME/.kube/config
# KUBE_COMMAND=$(kubectl --kubeconfig="$KUBECONFIG" "$2" -f -)

if [ ! -d $KF_home ]; then
  cd $BASE_DIR
  git clone https://github.com/awslabs/kubeflow-manifests.git
  cd kubeflow-manifests
  git checkout v1.4.1-aws-b1.0.0
  git clone --branch v1.4.1 https://github.com/kubeflow/manifests.git upstream

  ## deprecated k8s api update
  cd $KF_manifest 
  grep -rl networking.k8s.io/v1beta1 | xargs sed -i 's/networking.k8s.io\/v1beta1/networking.k8s.io\/v1/g'
  grep -rl admissionregistration.k8s.io/v1beta1 | xargs sed -i 's/admissionregistration.k8s.io\/v1beta1/admissionregistration.k8s.io\/v1/g'

fi

## test kubectl
kubectl --kubeconfig=$KUBECONFIG get ns 

## install kubeflow :: vanilla version 1.4
## notwork below command line  :: too many open
#while ! kustomize build $KF_home/docs/deployment/vanilla | kubectl --kubeconfig=$HOME/.kube/config $1 -f -; do echo "Retrying to apply resources"; sleep 10; done


kf_components=("cert-manager" "istio" "dex" "oidc" "knative")

# ## install cert-manager
# for i in ${kf_components[@]}
# do
  
  if [ "$1" == "all" ]; then
    cd $KF_manifest
    ## cert-manager
    kustomize build common/cert-manager/cert-manager/base | kubectl --kubeconfig=$KUBECONFIG $2 -f - 
    kustomize build common/cert-manager/kubeflow-issuer/base | kubectl --kubeconfig=$KUBECONFIG $2 -f - 
    
    ## istion
    kustomize build common/istio-1-9/istio-crds/base | kubectl --kubeconfig=$KUBECONFIG $2 -f - 
    kustomize build common/istio-1-9/istio-namespace/base | kubectl --kubeconfig=$KUBECONFIG $2 -f -
    kustomize build common/istio-1-9/istio-install/base | kubectl --kubeconfig=$KUBECONFIG $2 -f -
    
    ##dex
    kustomize build common/dex/overlays/istio | kubectl --kubeconfig=$KUBECONFIG $2 -f - 
    
    ## oidc
    kustomize build common/oidc-authservice/base | kubectl --kubeconfig=$KUBECONFIG $2 -f - 
    
    ## knative
    kustomize build common/knative/knative-serving/base | kubectl --kubeconfig=$KUBECONFIG $2 -f - 
    kustomize build common/istio-1-9/cluster-local-gateway/base | kubectl --kubeconfig=$KUBECONFIG $2 -f - 
    
    ## optionally knative eventing
    #kustomize build common/istio-1-9/cluster-local-gateway/base | kubectl --kubeconfig=$KUBECONFIG $2 -f - 
    
    ## kubeflow
    kustomize build common/kubeflow-namespace/base | kubectl --kubeconfig=$KUBECONFIG $2 -f -
    
    ## kubeflow roles
    kustomize build common/kubeflow-roles/base | kubectl --kubeconfig=$KUBECONFIG $2 -f -
    
    ## istio resources
    kustomize build common/istio-1-9/kubeflow-istio-resources/base | kubectl --kubeconfig=$KUBECONFIG $2 -f -
    
    ## multi-user kubeflow pipelines
    kustomize build apps/pipeline/upstream/env/platform-agnostic-multi-user | kubectl --kubeconfig=$KUBECONFIG $2 -f -
    
    ## KFserviing
    kustomize build apps/kfserving/upstream/overlays/kubeflow | kubectl --kubeconfig=$KUBECONFIG $2 -f -
    
    ## katib
    kustomize build apps/katib/upstream/installs/katib-with-kubeflow | kubectl --kubeconfig=$KUBECONFIG $2 -f -

    ## central dashboard 
    kustomize build apps/centraldashboard/upstream/overlays/istio | kubectl --kubeconfig=$KUBECONFIG $2 -f -

    ## admission webhook
    kustomize build apps/admission-webhook/upstream/overlays/cert-manager | kubectl --kubeconfig=$KUBECONFIG $2 -f -

    ## notebooks
    ### notebook controller
    kustomize build apps/jupyter/notebook-controller/upstream/overlays/kubeflow | kubectl --kubeconfig=$KUBECONFIG $2 -f -
    ### jupyter web app
    kustomize build apps/jupyter/jupyter-web-app/upstream/overlays/istio | kubectl --kubeconfig=$KUBECONFIG $2 -f -

    ## profiles and kubeflow access-managements(KFAM)
    kustomize build apps/profiles/upstream/overlays/kubeflow | kubectl --kubeconfig=$KUBECONFIG $2 -f -

    ## volumes web app
    kustomize build apps/volumes-web-app/upstream/overlays/istio | kubectl --kubeconfig=$KUBECONFIG $2 -f -
    
    ## tensorboard
    ### tensorboard webapp
    kustomize build apps/tensorboard/tensorboards-web-app/upstream/overlays/istio | kubectl --kubeconfig=$KUBECONFIG $2 -f -
    ### tensorboard controller
    kustomize build apps/tensorboard/tensorboard-controller/upstream/overlays/kubeflow | kubectl --kubeconfig=$KUBECONFIG $2 -f -

    ## training operator
    kustomize build apps/training-operator/upstream/overlays/kubeflow | kubectl --kubeconfig=$KUBECONFIG $2 -f -

    ## mpi operator
    kustomize build apps/mpi-job/upstream/overlays/kubeflow | kubectl --kubeconfig=$KUBECONFIG $2 -f -
    
    cd $KF_home 
    ## aws telemetry
    kustomize build awsconfigs/common/aws-telemetry | kubectl --kubeconfig=$KUBECONFIG $2 -f -

    cd $$KF_manifest
    ## user namespace
    kustomize build common/user-namespace/base | kubectl --kubeconfig=$KUBECONFIG $2 -f -
  fi


# done
