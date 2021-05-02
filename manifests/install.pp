# @summary
#   Installs the Restic package and creates the required user and group.
#
class restic::install {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $restic::package_manage {
    package { $restic::package_name:
      ensure => $restic::package_ensure,
    }
  }

  group { $restic::group:
    ensure => present,
  }
  -> user { $restic::user:
    ensure => present,
    groups => [$restic::group, 'users'],
    system => true,
    home   => "/home/${restic::user}/",
  }

  file { "/home/${restic::user}/":
    ensure  => directory,
    owner   => $restic::user,
    group   => $restic::group,
    mode    => '0644',
    require => User[$restic::user],
  }
}
