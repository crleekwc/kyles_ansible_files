# OPENSHIFT 4: AUTOMATE DAY 1 INSTALLATION AND DAY 2 OPERATIONS

# Description

Custom automation to install an OpenShift cluster on AWS into an existing VPC for day 1 install and to automate cluster autoscaling, set MachineSets as spot instances, configure cluster logging, configure StorageClasses, and configure custom certificates for day 2 operations.

### Background

There are many increased risks to manually installing an OpenShift cluster and escapes configuration control by performing day 1 installation and day 2 operations by hand.  An automated OpenShift 4.x cluster installed in the AWS environment reduces the time and decreases human error when deploying an OpenShift 4.x cluster through UPI.

Automation ensures the OpenShift 4.x automated installer conforms to the specific cloud settings such as tagging, security groups and network configurations.  The implemented automation will also preserve the cluster in a working state that is ready to receive day two operations and application workloads.

Day 1 Ansible automation leverages an Ansible Role to create CloudFormation templates to manage stacks of AWS resources and uses Ansible jinja templates to render installation files ingested for the installation of the platform

Day 2 Ansible automation leverages Ansible roles to perform operations on OpenShift 4.x cluster to configure cluster autoscaling, MachineSets as spot instances, EFK cluster logging, StorageClasses, and custom certificates

Additional configurations and maintenance are also provided

# Sections

[[_TOC_]]

## Before You Begin

Before beginning its recommended to read about the concepts of Red Hat OpenShift Installation and Ansible Operations:

* Red Hat OpenShift Official Documentation [OpenShift 4 Architecture and Installation Overview](https://docs.openshift.com/container-platform/latest/architecture/architecture-installation.html#architecture-installation)

* Red Hat OpenShift Official Documentation [Installing a Cluster on AWS into an Existing VPC](https://docs.openshift.com/container-platform/latest/installing/installing_aws/installing-aws-vpc.html)

* Red Hat Ansible Official Documentation [Ansible User Guide Documentation](https://docs.ansible.com/ansible/latest/user_guide/index.html#getting-started)

* Pipenv Basic Usage Documentation [Basic Usage of Pipenv](https://pipenv-fork.readthedocs.io/en/latest/basics.html)

# ANSIBLE AUTOMATION


**Day 1 Ansible Roles**
* [infrastructure](TODO) 

**Day 2 Ansible Roles**
* [ops_cluster_autoscaling](TODO/ocp4/day2/playbooks/roles/ops_cluster_autoscaling)
* [ops_cluster_image_custom_certificate](TODO/ocp4/day2/playbooks/roles/ops_cluster_image_custom_certificate)
* [ops_cluster_ingress_custom_certificate](TODO/ocp4/day2/playbooks/roles/ops_cluster_ingress_custom_certificate)
* [ops_efk](TODO/ocp4/day2/playbooks/roles/ops_efk)
* [ops_efs_storageclass](TODO/ocp4/day2/playbooks/roles/ops_efs_storageclass)
* [ops_machineset](TODO/ocp4/day2/playbooks/roles/ops_machineset)


## Prerequisites

- **REQUIRED**: Bastion host with installed packages: `python3, pip3, pipenv, bind-utils`
- **REQUIRED**: Red Hat OpenShift Installation [Prerequisites](https://docs.openshift.com/container-platform/latest/installing/installing_aws/installing-aws-vpc.html#prerequisites)
- **REQUIRED**: Red Hat OpenShift Installation [Installing a Cluster on AWS that Uses Mirrored Installation Content](https://docs.openshift.com/container-platform/latest/installing/installing_aws/installing-restricted-networks-aws.html#prerequisites)

<br />

# Usage and Requirements Before Using Installation and Operations Ansible Automation

### How to Setup Python Virtual Environment And Dependencies

```

1. Clone git repository and change working directory to use for OpenShift 4 Ansible Automation artifacts
  
   git clone </path/to/git/repo> && cd ocp4

2. Determine if environment has installed pipenv

   sudo python3 -m pip list | grep pipenv

   **************************************************************************
    If above command does not return pipenv as an installed python module,
               execute following command line to install pipenv   
   **************************************************************************                  

   sudo python3 -m pip install pipenv

3. At command line install python package dependencies in python virtual environment referencing the versioned Pipfile

   pipenv install

4. Spawn a shell in a virtual environment to isolate the development of the work (Ansible) directory

   pipenv shell


NOTES: Tips on activating, deactivating, and removing python3 virtual environments

######  ACTIVATE AN EXISTING PYTHON3 VIRTUAL ENVIRONMENT  ######

   cd <WORKING_DIRECTORY>
   source $(pipenv --venv)/bin/activate

######  DEACTIVATE AN EXISTING PYTHON3 VIRTUAL ENVIRONMENT IN SPAWN SHELL  ######

   deactivate

######  REMOVE AN EXISTING PYTHON3 VIRTUAL ENVIRONMENT  ######

   cd <WORKING_DIRECTORY>
   pipenv --rm

```
<br />

# Day 1 Installation

## Review

### Variables Defined for Phase 1 and Phase 2 of OpenShift Playbook Installation

Ansible automation is used in `infrastructure` role to configure AWS resources and install OpenShift 4 
in two phases. 

All variables listed below are required for successfuly Ansible playbook execution and 
must be define correctly per AWS environment and OpenShift cluster.

A variables file is populated with existing values and is located in `day1/group_vars/all.yml`

``` yml
---
- hosts: localhost
  connection: local
  vars:
    cluster_name: <CLUSTER_NAME_VALUE>
    base_domain: <CLUSTER_DOMAIN_NAME_VALUE>
    wildcard_name: <CLUSTER_WILDCARD_DOMAIN_VALUE>
    dns_server: <DNS_SERVER_IP_ADDR_VALUE>
    vpc_id: <NAME_OF_EXISTING_AWS_VPC_RESOURCE_ID_VALUE>
    vpc_cidr: <EXISTING_AWS_VPC_CIDR_VALUE>
    private_subnets: [NAME_OF_PRIVATE_SUBNET(S)]
    allowed_ingress_cidr: <ALLOWED_INGRESS_CIDR_VALUE>
    aws_default_security_group_id: <NAME_OF_DEFAULT_AWS_SECURITY_GROUP_VALUE>
    instance_worker_type: <NAME_OF_AWS_INSTANCE_TYPE_FOR_WORKER_NODES_VALUE>
    user_tags:
        Backup: <AWS_TAG_VALUE>
        Cluster: <AWS_TAG_VALUE>
        ServerFunction: <AWS_TAG_VALUE>
        System: <AWS_TAG_VALUE>
        Environment: <AWS_TAG_VALUE>
        FismaId: <AWS_TAG_VALUE>
        POC: <AWS_TAG_VALUE>
        Scheduler: <AWS_TAG_VALUE>
    registry_ca_trust_bundle: <NAME_OF_REGISTRY_CA_TRUSTED_BUNDLE_VALUE>
    registry_mirror_url: <NAME_OF_MIRRORED_REGISTRY_VALUE>
    pull_secret: !vault |
            $ANSIBLE_VAULT;1.1;AES256
            30613233633461343837653833666333643061636561303338373661313838333565653635353162
            6330
  roles:
    - infrastructure
```



 | Varible   | Default   | Type   | Optional  | Description   |
 |------------|-----------|-----------|-------|--------|
 | cluster_name | cluster1 | String | No | Name of Cluster |
 | base_domain | ocp.local | String | No | Top Level Domain(s) and Sub-Level Domain(s) |
 | wildcard_name | apps | String | No | Wildcard Sub-Level Domain for Cluster Applications |
 | dns_server | localhost | String | Yes | DNS Server IP Address or Name|
 | vpc_id | "" | String | No | AWS Virtual Private Cloud ID |
 | vpc_cidr | "" | String | No | AWS Virtual Private Cloud CIDR Range|
 | private_subnets| [ ] | List | No | Indexed List of AWS Private Subnet(s) |
 | allowed_ingress_cidr | "" | String| No | Ingress CIDR Range for Cluster |
 | aws_default_security_group_id| "" | String | No | Default AWS Security Group ID |
 | instance_worker_type | m5.large | String| Yes | AWS Instance Type for Worker Nodes |
 | user_tags | { } | Dictionary | No | Key/Value Dictionary for AWS Tag(s) to Resources |
 | registry_ca_trust_bundle | "" | String | Yes | Registry CA Trusted Chain Certificate(s) |
 | registry_mirror_url | registry.redhat.io | String | No | Registry for OpenShift 4 Container Image(s) |
 | pull_secret | ""| String | No | Registry Pull Secret for OpenShift 4 Installation Authentication |

<br />


# Day 1 Automated Installation

### How to Run Ansible Playbook to Perform Phase 1 and Phase 2 OCP 4 Automated Install

```

1. Clone git repository and change working directory to use for OpenShift 4 Ansible Automation artifacts
  
   git clone </path/to/git/repo> && cd ocp4/day1
  
2. At command line, execute ansible-playbook for phase1 entering Ansible vault credentials at prompt to decrypt
   sensitive variable data

   ansible-playbook -e "@group_vars/all.yml" playbooks/phase1.yml --ask-vault-pass

3. At command line, execute ansible-playbook for phase2 entering Ansible vault credentials at prompt to decrypt
   sensitive variable data

   ansible-playbook -e "@group_vars/all.yml" playbooks/phase2.yml --ask-vault-pass

```
</br>

# Day 2 Operations

## Review

### Variables Defined for Configuring OpenShift Playbook Operations

Ansible automation configures OpenShift 4 resources using six roles below

```

ops_cluster_autoscaling
ops_cluster_image_custom_certificate
ops_cluster_ingress_custom_certificate
ops_efk
ops_efs_storageclass
ops_machineset

```

All variables listed below are required for successfuly Ansible playbook execution and 
must be define correctly per AWS environment and OpenShift cluster.

A variables file is populated with existing values and is located in `day2/group_vars/all.yml`

``` yml
---
- hosts: localhost
  connection: local
  vars:
    cluster_name: <CLUSTER_NAME_VALUE>
    base_domain: <CLUSTER_DOMAIN_NAME_VALUE>
    infrastructure_name: <CLUSTER_INFRASTRUCTURE_NAME_VALUE>
    efs_hostname: <NAME_OF_EFS_HOSTNAME_VALUE>
    efs_fqdn: <NAME_OF_EFS_FQDN_VALUE>
    efs_filesystem_id: <NAME_OF_AWS_EFS_FILE_SYSTEM_ID_VALUE>
  roles:
    - ops_cluster_image_custom_certificate
    - ops_cluster_ingress_custom_certificate
    - ops_machineset
    - ops_cluster_autoscaling
    - ops_efs_storageclass
    - ops_efk
```



 | Varible   | Default   | Type   | Optional  | Description   |
 |------------|-----------|-----------|-------|--------|
 | cluster_name | "" | String | No | Name of Cluster |
 | base_domain | "" | String | No | Top Level Domain(s) and Sub-Level Domain(s) |
 | infrastructure_name | "" | String | No | Name of Cluster Infrastructure |
 | efs_hostname | "" | String | No | EFS Hostname |
 | efs_fqdn | "" | String | No | EFS FQDN |
 | efs_filesystem_id | "" | String | No | EFS File System ID |


<br />

# Day 2 Automated Configured Operations

### How to Run Ansible Playbook to Configure Automated Operations on OCP 4

```

1. Clone git repository and change working directory to use for OpenShift 4 Ansible Automation artifacts
  
   git clone </path/to/git/repo> && cd ocp4/day2
  
2. At command line, execute ansible-playbook for configuring OCP 4 operations

   ansible-playbook -e "@group_vars/all.yml" playbooks/configure-day2-operations.yml


```
</br>

# ADDITIONAL CONFIGURATION


Additional configuration to support operation(s):

* Configure Alertmanager and Microsoft Teams Integration
* Configure Machinesets as AWS spot instance(s) 

## Alertmanager 

* [Alertmanager](TODO/additional-configuration/alertmanager)

## Machinesets

* [Machinesets](TODO/additional-configuration/machinesets)

</br>

# MAINTENANCE


Automation to support maintenance operations - e.g. cluster shutdown / startup

* **REQUIRED**: Appropriate AWS credentials and permissions are required

## Cluster Shutdown and Startup

* [Cluster Maintenance](TODO/maintenance)

</br>

# OPEN ID CONNECT + OAUTH


## OIDC

* [OIDC+OAUTH](TODO/oidc)

</br>

# Get Involved

*  Submit an issue on bugs, errata, suggestions, or feedback
*  Submit a proposed code update through a pull request to the ``develop`` branch.
*  Engage in discussion before making larger changes
   to avoid duplicate efforts. This not only helps everyone
   know what is going on, it also helps save time and effort if team decides
   some changes are needed.
