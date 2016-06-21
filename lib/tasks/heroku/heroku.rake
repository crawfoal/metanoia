require 'open3'
require_relative '../db/populate'
require_relative 'app_commander'

# :nocov:
namespace :heroku do
  namespace :db do
    desc "reset the database, seed it, and then fill it with sample data"
    task :populate, [:app_name] => [:protected] do |_t, args|
      unless args[:app_name].present?
        raise 'Error: you must specify the app name'
      end
      app_commander = Tasks::Heroku::AppCommander.new(args[:app_name])
      app_commander.run_heroku_reset
    end
  end
end
# :nocov:
