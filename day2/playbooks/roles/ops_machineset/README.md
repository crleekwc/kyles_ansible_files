ops_machineset
==============

Configures registries to get container images on an OpenShift Container Platform cluster

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
    - role: ops_machineset
      vars:
        cluster_name: cluster1
        base_domain: ocp.local
```

Document Reference
------------------
Red Hat OpenShift Official Documentation [Configuring Container Image Registry Settings](https://docs.openshift.com/container-platform/latest/post_installation_configuration/machine-configuration-tasks.html#machineconfig-modify-registry_post-install-machine-configuration-tasks)

License
-------

BSD

Author Information
------------------

TODO