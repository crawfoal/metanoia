module TaskHelper
  def run_rake_task(task_name)
    Rake::Task[task_name].reenable
    Rake.application.invoke_task task_name
  end
end

RSpec.configure do |config|
  config.include TaskHelper, type: :task
end
