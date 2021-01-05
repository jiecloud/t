#!/bin/bash
#https://github.com/alitoufighi
#https://github.com/kubernetes/kubernetes/issues/43867

help(){
    __usage="  SYNOPSIS
        ./make_namespace -n <new-namespace-name> -t <template-namespacce-name> [-b branch name]"
    echo "$__usage"
}


PARSED_OPTIONS=$(getopt -n "$0"  -o ht:n:b: --long "help, template, branch, new-namespace"  -- "$@")

#Bad arguments, something has gone wrong with the getopt command.
if [[ $? -ne 0 ]];
then
  exit 1
fi

# CHANGEME
required_resources=("services" "serviceaccount" "deployment" "configmap" "job")

# A little magic, necessary when using getopt.
eval set -- "${PARSED_OPTIONS}"
new_namespace=
template_namespace=
branch_name=

# Now goes through all the options with a case and using shift to analyse 1 argument at a time.
#$1 identifies the first argument, and when we use shift we discard the first argument, so $2 becomes $1 and goes again through the case.
while true;
do
  case "$1" in
    -h|--help)
      help
      exit 0;
      shift;;
    -n|--new-namespace)
        if [[ -n "$2" ]]; then
            new_namespace=$2
        fi
        shift 2;;
    -b|--branch)
        if [[ -n "$2" ]]; then
            branch_name=$2
        fi
        shift 2;;
    -t|--template)
        if [[ -n "$2" ]]; then
            template_namespace=$2
        fi
        shift 2;; 
    --)
      shift
      break;;
  esac
done

if [[ -z $new_namespace ]] || [[ -z $template_namespace ]]; then
    help
    exit 1;
fi
if [[ -z $branch_name ]]; then
    branch_name=$new_namespace
fi

#collect all yaml files from temlpate namespace and make some changes on them to use in new namespace
for resource_type in ${required_resources[@]}; do 
    resources=$(kubectl -n $template_namespace get $resource_type | awk '{print$1}')
    resources=(${resources#'NAME'})
    for current_resource in ${resources[@]}; do
        echo "preparing $resource_type/$current_resource..."
        current_resource_file=$current_resource.yaml 
        kubectl -n $template_namespace get $resource_type/$current_resource -o yaml >> $current_resource_file 
        yq w -i $current_resource_file metadata.namespace $new_namespace
        yq d -i $current_resource_file metadata.annotation
        if [ $resource_type == "job" ]; then
            yq d -i $current_resource_file spec.selector
            yq d -i $current_resource_file spec.template.metadata.labels
            job_image_path="spec.template.spec.containers.[0].image"
            job_image=$(yq r $current_resource_file "$job_image_path")
            new_job_image=${job_image/$template_namespace/$new_namespace}
            yq w -i $current_resource_file "$job_image_path" $new_job_image
        fi
    done
done

#make a new namespace with desired name
kubectl create namespace $new_namespace

#apply everything obtained from template namespace
kubectl apply -n $new_namespace -f . -R
