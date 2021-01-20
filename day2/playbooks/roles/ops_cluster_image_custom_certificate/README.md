ops_cluster_image_custom_certificate
====================================

Configures additional trust store(s) for image registry access and updates the Samples Operator configuration on an OpenShift Container Platform cluster

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
    - role: ops_cluster_image_custom_certificate
      vars:
        cluster_name: cluster1
        base_domain: ocp.local
```

Document Reference
------------------
Red Hat OpenShift Official Documentation [Configuring Additional Trust Stores for Image Registry Access](https://docs.openshift.com/container-platform/latest/registry/configuring-registry-operator.html#images-configuration-cas_configuring-registry-operator)

Red Hat OpenShift Official Documentation [Accessing the Samples Operator Configuration](https://docs.openshift.com/container-platform/latest/openshift_images/configuring-samples-operator.html#samples-operator-crdconfiguring-samples-operator)

License
-------

BSD

Author Information
------------------

TODO