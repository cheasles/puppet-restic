#
## This function manages a Restic backup.
##
## Parameters:
##
##   path        - The data to backup.
##   repository  - The path to the repository.
##   timer       - How often to backup in systemd timer format.
##   user        - The user to execute the backup as.
##   group       - The group to execute the backup as.
##   ensure      - Either present or removed.
##   password    - The password to use when opening the repository.
#
define restic::backup (
  String                    $repository,
  String                    $password,
  String                    $path = $title,
  Enum['present', 'absent'] $ensure = 'present',
  String                    $user = $restic::user,
  String                    $group = $restic::group,
  String                    $timer = '*-*-* 00:00:00',
) {
  systemd::service::simple { "restic-backup-${name}":
    unit_ensure   => stopped,
    description   => "Restic Backup ${name}",
    service_user  => $user,
    service_group => $group,
    after         => 'network.target',
    exec_start    => "/usr/bin/restic -r ${repository} backup ${path}",
    environment   => "RESTIC_PASSWORD=${password}",
  }
  systemd::unit::timer { "restic-backup-${name}":
    description   => "Restic Backup ${name} timer",
    timer_options => {
      'OnCalendar' => $timer,
      'Persistent' => 'true',
    },
  }
}
