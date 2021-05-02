#
## This function manages a Restic backup repository.
## Currently, only local repositories are supported.
##
## Parameters:
##
##   path        - The path to the repository.
##   ensure      - Either present or removed.
##   type        - The type of repository to create.
#
define restic::repository (
  String                    $password,
  String                    $path = $title,
  Enum['present', 'absent'] $ensure = 'present',
  Enum['local']             $type = 'local',
) {
  exec { "init restic respository ${title}":
    command     => "restic init --repo ${path}",
    path        => '/usr/bin:/usr/sbin:/bin:/sbin',
    environment => ["RESTIC_PASSWORD=${password}"],
    creates     => "${path}/config",
    user        => $restic::user,
    group       => $restic::group,
  }
}
