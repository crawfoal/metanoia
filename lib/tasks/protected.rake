desc 'Raises an exception if the task is run and the `ALLOW_PROTECTED_TASKS` environment variable is not set.'
task protected: [:environment] do
  unless ENV['ALLOW_PROTECTED_TASKS']
    raise '!!! You cannot run this task for a production database !!!'
  end
end
