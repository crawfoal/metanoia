require 'open3'
require_relative 'db/populate'

namespace :heroku do
  namespace :db do
    desc "reset the database, seed it, and then fill it with sample data"
    task :populate, [:app_name] => [:protected] do |t, args|
      app_commander = Tasks::Heroku::AppCommander.new(args[:app_name])
      unless app_commander.run_command('pg:reset DATABASE_URL')
        raise 'pg:reset failed... aborting'
      end
      app_commander.run_task('db:schema:load')
      app_commander.run_task('db:seed')
      app_commander.run_command('restart')
      app_commander.run_task('db:fill')
    end
  end
end

module Tasks
  module Heroku
    class AppCommander
      def initialize(app_name)
        @app_name = app_name
      end

      def run_command(cmd)
        Bundler.with_clean_env do
          system("heroku #{cmd} --app #{@app_name}")
        end
      end

      def run_task(task)
        Bundler.with_clean_env do
          system("heroku run rake #{task} --app #{@app_name}")
        end
      end
    end
  end
end
