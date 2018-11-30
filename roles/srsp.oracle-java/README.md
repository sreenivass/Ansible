
srsp.oracle-java for Ansible Galaxy
============

[![Build Status](https://travis-ci.org/srsp/ansible-oracle-java.svg?branch=master)](https://travis-ci.org/srsp/ansible-oracle-java) 

## Summary

Role name in Ansible Galaxy: **[srsp.oracle-java](https://galaxy.ansible.com/srsp/oracle-java/)**

This Ansible role has the following features for Oracle JDK:

 - Install JDK 8 or 10 in the latest version.
 - Install optional Java Cryptography Extensions (JCE). Only for JDK 8, because it is no longer needed for JDKs > 8.
 - Install for CentOS, Debian/Ubuntu, SUSE, and Mac OS X families.
 
 **Attention:** As of April 2018 older versions of JDKs are no longer available publicly on the Oracle website. You need an Oracle account to download these. This role
 does not support downloading roles with an Oracle account. This means, that you can only download the latest version of all JDKs that have not yet reached their EOL with this role!
 
However you can still use this role to install older versions, if you download them and provide them as pre-downloaded file or via http (just define `java_mirror` accordingly).
 
This role is based on [williamyeh.oracle-java](https://github.com/William-Yeh/ansible-oracle-java), but I wanted more recent Java versions and decided to drop support for older versions.

If you prefer OpenJDK, try alternatives such as [geerlingguy.java](https://galaxy.ansible.com/geerlingguy/java/) or [smola.java](https://galaxy.ansible.com/smola/java/).


## Role Variables

### Mandatory variables

None, but it is strongly advised to `java_version: 8` or `java_version: 10`, which would give you the latest version of either one.

### Optional variables


User-configurable defaults:

```yaml
# which version?
java_version: 8

# which subversion?
java_subversion: 172

# which directory to put the download file?
java_download_path: /tmp

# rpm/tar.gz file location:
#   - true: download from Oracle on-the-fly;
#   - false: copy from `{{ playbook_dir }}/files` on the control machine.
java_download_from_oracle: true

# if you set java_download_from_oracle to true, you can define an alternative download location. Default is the official Oracle website.
java_mirror: http://download.oracle.com/otn-pub/java

# remove temporary downloaded files?
java_remove_download: true

# set $JAVA_HOME?
java_set_javahome: false

# install JCE?
java_install_jce: false
```

For other configurable internals, read `tasks/set-role-variables.yml` file; for example, supported `java_version`/`java_subversion` combinations.

### I want to install a JDK which you don't yet support!

No problem! You have to specify the corresponding Java build number in the variables `java_build` and `jdk_tarball_hash` in addition to `java_version` and `java_subversion`, e.g.


```yaml
- hosts: all

  roles:
    - srsp.oracle-java

  vars:
    - java_version: 8
    - java_subversion: 141
    - java_build: 15
    - jdk_tarball_hash: 336fa29ff2bb4ef291e347e091f7f4a7
```


### JDK 10 variables

If you want to use the latest JDK 10: 

```yaml
- hosts: all

  roles:
    - srsp.oracle-java

  vars:
    - java_version: 10 
```


### JDK 9 variables

JDK 9 is only available in version 9.0.4. If you want to use it, set the following vars and provide it as tarball (see next section):

```yaml
- hosts: all

  roles:
    - srsp.oracle-java

  vars:
    - java_version: 9 
```


### Customized variables, if absolutely necessary

If you have a pre-downloaded `jdk_tarball_file` whose filename cannot be inferred successfully by `tasks/set-role-variables.yml`, you may specify it explicitly: 

```yaml
# Specify the pre-fetch filename (without tailing .tar.gz or .rpm or .dmg);
# used in conjunction with `java_download_from_oracle: false`.

jdk_tarball_file

# For example, if you have a `files/jdk-8u172-linux-x64.tar.gz` locally,
# but the filename cannot be inferred successfully by `tasks/set-role-variables.yml`,
# you may specify the following variables in your playbook:
#
#    java_version:    8
#    java_subversion: 172
#    java_download_from_oracle: false
#    jdk_tarball_file: jdk-8u172-linux-x64
#
```


## Usage


### Step 1: add role

Add role name `srsp.oracle-java` to your playbook file.


### Step 2: add variables

Set vars in your playbook file.

Simple example:

```yaml
# file: simple-playbook.yml

- hosts: all

  roles:
    - srsp.oracle-java

  vars:
    - java_version: 8
```


### (Optionally) pre-fetch .rpm, .tar.gz or .dmg files

For some reasons, you may want to pre-fetch .rpm, .tar.gz or .dmg files *before the execution of this role*, instead of downloading from Oracle on-the-fly.

To do this, put the file on the `{{ playbook_dir }}/files` directory in advance, and then set the `java_download_from_oracle` variable to `false`:

```yaml
# file: prefetch-playbook.yml

- hosts: all

  roles:
    - srsp.oracle-java

  vars:
    - java_version: 8
    - java_download_from_oracle: false
```






## Dependencies


## License

Licensed under the Apache License V2.0. See the [LICENSE file](LICENSE) for details.

