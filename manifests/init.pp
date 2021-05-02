# @summary
#   Module to install Restic and manage backups
#
# @param user
#   The user to create who owns the backup files.
#
# @param group
#   The group to create who owns the backup files.
#
# @param package_manage
#   Enable to manage the Restic package install.
#
# @param package_ensure
#   The version of Restic to install.
#
# @param package_name
#   The name of the Restic package to install.
#
# @param repositories
#   A hash of Restic repositories to create.
#
# @param backups
#   A hash of backups to manage.
#
class restic(
    String  $user = 'restic',
    String  $group = 'restic',
    Boolean $package_manage = true,
    String  $package_ensure = latest,
    String  $package_name = 'restic',
    Hash    $repositories = {},
    Hash    $backups = {},
) {
    anchor { "${module_name}::begin": }
    -> class { "${module_name}::install": }
    -> anchor { "${module_name}::end": }

    create_resources('restic::repository', $repositories)
    create_resources('restic::backup', $backups)
}
