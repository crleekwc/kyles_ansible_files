#!/usr/bin/env bash

export KUBECONFIG=</path/to/kubeconfig>      # e.g. kubeconfig location
export CLUSTER_NAME=<name_of_cluster>        # e.g. cluster1
export DNS_SUFFIX=<name_of_subdomain_tld>    # e.g. ocp.local
#export AWS_EAST_AZ_ID="c d"                  # e.g. us-east-1b
export INFRA_NAME=`echo -e "$CLUSTER_NAME-$(echo -n $CLUSTER_NAME$DNS_SUFFIX | sha256sum | awk '{ print $1 }' | tail -c6)\n"`

for i in $AWS_EAST_AZ_ID
  do echo "Setting Machineset $CLUSTER_NAME-$INFRA_NAME-worker-us-east-1$i spot instance"
  oc patch machineset $CLUSTER_NAME-$INFRA_NAME-worker-us-east-1$i -n openshift-machine-api --type='json' --patch '[{"op":"add","path":"/spec/template/spec/providerSpec/value/spotMarketOptions", "value": {} }]'  
done
