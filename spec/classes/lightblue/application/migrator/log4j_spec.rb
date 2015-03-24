require 'spec_helper'

describe 'lightblue::application::migrator::log4j' do
  
  config_dir = '/etc/migrator'
  log_file = '/var/log/migrator/migrator.log'
  
  context 'defaults' do
    let :params do
      {
        :config_dir => config_dir,
        :log_file => log_file,
        :owner => 'root',
        :group => 'root',
      }
    end
    
    it do      
      should contain_file("#{config_dir}/log4j.properties").with({
        'ensure' => 'file',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      }) \
        .with_content(/^log4j.rootLogger=INFO,file$/) \
        .with_content(/^log4j.appender.file.File=#{log_file}$/) \
        .with_content(/^log4j.appender.file.MaxFileSize=10MB$/) \
        .with_content(/^log4j.appender.file.MaxBackupIndex=50$/) \
        .with_content(/^log4j.appender.file.layout.ConversionPattern=\%d \[\%t\] \%-5p \[\%c\] \%m\%n$/)
    end
  end
  
  context 'customized variables' do
    log_level = 'DEBUG'
    log_max_file_size = '5MB'
    log_max_backups_to_keep = '20'
    log_pattern = 'some pattern'
    
    let :params do
      {
        :config_dir => config_dir,
        :log_file => log_file,
        :owner => 'root',
        :group => 'root',
        :log_level => log_level,
        :log_max_file_size => log_max_file_size,
        :log_max_backups_to_keep => log_max_backups_to_keep,
        :log_pattern => log_pattern,
      }
    end
    
    it do      
      should contain_file("#{config_dir}/log4j.properties") \
        .with_content(/^log4j.rootLogger=#{log_level},file$/) \
        .with_content(/^log4j.appender.file.MaxFileSize=#{log_max_file_size}$/) \
        .with_content(/^log4j.appender.file.MaxBackupIndex=#{log_max_backups_to_keep}$/) \
        .with_content(/^log4j.appender.file.layout.ConversionPattern=#{log_pattern}$/)
    end
  end

end
