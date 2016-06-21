require 'rails_helper'
require 'rake'

module TaskHelper
  def run_rake_task(task_name, *args)
    Rake::Task[task_name].reenable
    capture_stdeo { Rake::Task[task_name].invoke(*args) }
  end
end

RSpec.configure do |config|
  config.include TaskHelper, type: :task

  config.before :suite do
    Rails.application.load_tasks
  end
end
