#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with puppet-restic](#setup)
    * [What puppet-restic affects](#what-puppet-restic-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with puppet-restic](#beginning-with-puppet-restic)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module manages [Restic](https://restic.net/) backups via Puppet.

## Module Description

This module provides multiple Puppet classes that can be used to manage Restic repositories and backups.

## Setup

### What puppet-restic affects

* Installs the Restic package using the system package manager.
* Creates a new user/group to own backup repositories.
* Creates SystemD services and timers to automatically backup specified data on a set schedule.

### Setup Requirements

This module uses the system package manager to install Restic.
If your package manager doesn't have a Restic package then this probably won't work.

### Beginning with puppet-restic

To get started, simply include the `restic` class as follows:

``` puppet
include ::restic
```

You then need to define a base repository to backup to.
You can do this in Puppet code or via Hiera:

``` yaml
restic::repositories:
  '/mnt/backup':
    ensure: present
    password: 'mysuperpassword'
```

Now you can periodically backup to that repository with the following Hiera:

``` yaml
restic::backups:
  'home':
    path: '/home'
    repository: '/mnt/backup'
    password: "%{lookup('restic::repositories.\"/mnt/backup\".password')}"
    timer: '*-*-* 06:00:00'
```

This will backup the `/home` folder everyday at 6AM.

## Reference

### Classes

* `restic`: The main class used to install the module and manage resources.
* `restic::install`: Installs Restic using the package manager and creates the required user and group.

### Define Resources

* `restic::backup`: Controls backing up data to a `restic::repository`.
* `restic::repository`: Creates a new Restic repository to store backed-up files.

## Limitations

This module has only been tested on Debian 9 and 10.

## Development

If you'd like to contribute, please see [CONTRIBUTING](CONTRIBUTING.md).
