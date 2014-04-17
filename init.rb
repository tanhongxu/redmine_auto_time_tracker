Rails.logger.info 'Starting Auto Time Tracker plugin for RedMine'

require 'redmine'

require 'ceo_auto_time_tracker_hooks'

if Rails::VERSION::MAJOR < 3
  require 'dispatcher'
  object_to_prepare = Dispatcher
else
  object_to_prepare = Rails.configuration
  # if redmine plugins were railties:
  # object_to_prepare = config
end

Redmine::Plugin.register :redmine_auto_time_tracker do
    name 'Redmine Auto Time Tracker plugin'
    author 'James Tan'
    description 'auto start/stop time tracker according to issue status'
    version '1.0'

    requires_redmine :version_or_higher => '2.4.0'
    
end

object_to_prepare.to_prepare do
  RbTasksController.send(:include, CEOAutoTimeTrackerPatch)
end