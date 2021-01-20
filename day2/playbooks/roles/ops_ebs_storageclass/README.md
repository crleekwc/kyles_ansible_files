ops_efs_storageclass
====================

Configures EFS storage class and provisioner on an OpenShift Container Platform cluster

Requirements
------------

* python >= 2.7
* openshift >= 0.6
* PyYAML >= 3.11

Role Variables
--------------

| Name                          | Default value |               Description                    |
|-------------------------------|---------------|----------------------------------------------|
| cluster_name     | ""         | Name of Cluster                                              |
| base_domain      | ""         | Name of Domain(s)                                            |
| efs_hostname     | ""         | Name of EFS Hostname                                         |
| efs_filesystem_id    | "{{ efs_hostname }}"           | Name of EFS File System ID           |

Dependencies
------------

None

Example Playbook
----------------

```yaml
---
- hosts: localhost
  roles:
    - role: ops_efs_storageclass
      vars:
        cluster_name: cluster1
        base_domain: ocp.local
        efs_hostname: efs-host
```

Document Reference
------------------
Red Hat OpenShift Official Documentation [Create the EFS Storage Class](https://docs.openshift.com/container-platform/latest/storage/persistent_storage/persistent-storage-efs.html#efs-storage-class_persistent-storage-efs)

Red Hat OpenShift Official Documentation [Create the EFS Provisioner](https://docs.openshift.com/container-platform/latest/storage/persistent_storage/persistent-storage-efs.html#efs-provisioner_persistent-storage-efs)

License
-------

BSD

Author Information
------------------

TODO