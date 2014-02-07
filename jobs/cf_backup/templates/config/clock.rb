require 'clockwork'
module Clockwork
  configure do |config|
    config[:sleep_timeout] = 5
    config[:max_threads] = 2
    config[:thread] = true
  end

  handler do |job|
    backup_config = '/var/vcap/jobs/cf_backup/config/config.rb'
    system "backup perform --trigger #{job} --config-file #{backup_config}"
  end

  every(<%= p('cf_backup.frequency') %>, 'cf_backup')
end
