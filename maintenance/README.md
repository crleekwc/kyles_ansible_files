# OpenShift 4: Operations to Shutdown and Startup Cluster

## Purpose:

The purpose of this document is to support operators performing routine maintenance on the cluster and requires cluster nodes to be shutdown or started. 

## Audience:
All stakeholders looking to save on costs and perform efficient maintenance operations

# Perform Cluster Shutdown or Startup

## Prerequisites

**SET AWS CLI ENVIRONMENT VARIABLES**
```
$ export AWS_ACCESS_KEY_ID=xxxxxxEXAMPLE
$ export AWS_SECRET_ACCESS_KEY=xxxxxxEXAMPLEKEY
$ export AWS_DEFAULT_REGION=us-east-1
```

### Ansible Variables Defined for Cluster Shutdown or Startup

`cluster_is_running=[ yes | no ]` &nbsp;&nbsp; **Defaults to yes**

### How to Run Ansible Playbook to Initialize Shutdown or Startup for Cluster

```

1. Clone git repository and change working directory to use for OpenShift 4 Ansible Automation artifacts
  
   git clone </path/to/git/repo> && cd ocp4/maintenance

2. Select an Operation Below


                              Shutdown Cluster

ansible-playbook set-cluster-running-state.yml -i inventory -e cluster_is_running=no


                              Startup Cluster

ansible-playbook set-cluster-running-state.yml


```