ops_cluster_ingress_custom_certificate
======================================

Configures and replaces the default ingress certificate for all applications under the .apps subdomain to have encryption provided by specified certificate on an OpenShift Container Platform cluster

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
    - role: ops_cluster_ingress_custom_certificate
      vars:
        cluster_name: cluster1
        base_domain: ocp.local
```

Document Reference
------------------
Red Hat OpenShift Official Documentation [Replacing the Default Ingress Certificate](https://docs.openshift.com/container-platform/latest/security/certificates/replacing-default-ingress-certificate.html#replacing-default-ingress_replacing-default-ingress)

License
-------

BSD

Author Information
------------------

TODO