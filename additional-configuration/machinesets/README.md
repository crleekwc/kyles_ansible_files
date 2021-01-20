# OpenShift 4: Creating Spot Instances by using MachineSets

## Purpose:

The purpose of this document is to deploy and configure MachineSet running on AWS that deploys machines as non-guaranteed Spot Instances. 

Spot Instances use available AWS EC2 capacity and are less expensive than On-Demand Instances.

## Audience:
All stakeholders looking to save on costs.

Operators can use Spot Instances for workloads that can tolerate interruptions, such as batch or stateless, horizontally scalable workloads.

## Planning and Considerations:
AWS EC2 can terminate a Spot Instance at any time. 
AWS gives a two-minute warning to the user when an interruption occurs. OpenShift Container Platform begins to remove the workloads from the affected instances when AWS issues the termination warning.

Interruptions can occur when using Spot Instances for the following reasons:

* The instance price exceeds your maximum price.

* The demand for Spot Instances increases.

* The supply of Spot Instances decreases.

```
NOTE: 	

It is strongly recommended that control plane machines are not created on Spot Instances due to the increased likelihood of the instance being terminated. 

Manual intervention is required to replace a terminated control plane node.
```

## Steps:

```

1. Clone git repository and change working directory to use for OpenShift 4 Automation additional-configuration artifacts
  
   git clone </path/to/git/repo> && cd ocp4/additional-configuration/machinesets

2. Edit machinesetspot.sh and add correct environment shell variables

     e.g.
     export KUBECONFIG=</path/to/kubeconfig>      # e.g. kubeconfig location
     export CLUSTER_NAME=<name_of_cluster>        # e.g. cluster1
     export DNS_SUFFIX=<name_of_subdomain_tld>    # e.g. ocp.local
     export AWS_EAST_AZ_ID="c d"                  # e.g. us-east-1b

3. At command line, execute machinesetspot.sh to configure machineset spot instances

     bash machinesetspot.sh

```