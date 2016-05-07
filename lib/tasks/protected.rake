require_relative 'communicator'

desc 'Raises an exception if the task is run and the `ALLOW_PROTECTED_TASKS` '\
     'environment variable is not set.'
task :protected do
  if ENV['STOP_PROTECTED_TASKS']
    raise '!!! This is a protected task and this environment does not allow '\
          'protected tasks. !!!'
  elsif ENV['HEROKU_APP_NAME'] &&
        ENV['HEROKU_APP_NAME'] != Tasks::Protected::Communicator.get_app_name
    raise 'You are attempting to apply changes to the wrong environment, or '\
          'you miss-typed the application name.'
  end
end

module Tasks
  module Protected
    class Communicator < Tasks::Communicator
      class << self
        def get_app_name
          # :nocov:
          print 'This is a potentially dangerous task. Please confirm the '\
                'application name: '
          gets.chomp
          # :nocov:
        end
      end
    end
  end
end
