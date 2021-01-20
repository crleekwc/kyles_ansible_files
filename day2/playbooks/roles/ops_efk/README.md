ops_efk
=======

Install and Configure the Elasticsearch Operator and Cluster Logging Operator on an OpenShift Container Platform cluster

Requirements
------------

* python >= 2.7
* openshift >= 0.6
* PyYAML >= 3.11

Role Variables
--------------

| Name                          | Default value |               Description                    |
|-------------------------------|---------------|----------------------------------------------|
| cluster_name     | ""          | Name of Cluster |
| base_domain    | ""            | Name of Domain(s)                                    |

Dependencies
------------

None

Example Playbook
----------------

```yaml
---
- hosts: localhost
  roles:
    - role: ops_efk
      vars:
        cluster_name: cluster1
        base_domain: ocp.local
```

Document Reference
------------------
Red Hat OpenShift Official Documentation [Installing Cluster Logging](https://docs.openshift.com/container-platform/latest/logging/cluster-logging-deploying.html#cluster-logging-deploy-cli_cluster-logging-deploying)

License
-------

BSD

Author Information
------------------

TODO