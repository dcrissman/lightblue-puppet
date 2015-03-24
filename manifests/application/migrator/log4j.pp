class lightblue::application::migrator::log4j(
  $log_level = 'INFO',
  $log_file = 'migrator.log',
  $log_max_file_size = '10MB',
  $log_max_backups_to_keep = '50',
  $log_pattern = '%d [%t] %-5p [%c] %m%n',
  $config_dir,
  $owner,
  $group,
) {

  $log4j_config_file = "$config_dir/log4j.properties"

  file{ $log4j_config_file:
    ensure  => 'file',
    mode    => '0644',
    owner   => $owner,
    group   => $group,
    content => template('lightblue/application/migrator/log4j.properties.erb'),
  }

}
