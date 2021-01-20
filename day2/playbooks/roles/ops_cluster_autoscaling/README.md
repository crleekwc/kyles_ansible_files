ops_cluster_autoscaling
=======================

Configures autoscaling to an OpenShift Container Platform cluster

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
| infrastructure_name    | ""            | Name of Cluster Infrastructure                                       |

Dependencies
------------

None

Example Playbook
----------------

```yaml
---
- hosts: localhost
  roles:
    - role: ops_cluster_autoscaling
      vars:
        cluster_name: cluster1
        base_domain: ocp.local
        infrastructure_name: cluster1-91eb7 
# infrastructure_name = echo -e "cluster1-$(echo -n cluster1ocp.local | sha256sum | awk '{ print $1 }' | tail -c6)\n"
```

Document Reference
------------------
Red Hat OpenShift Official Documentation [Applying Autoscaling to an OpenShift Container Platform Cluster](https://docs.openshift.com/container-platform/latest/machine_management/applying-autoscaling.html)

License
-------

BSD

Author Information
------------------

TODO