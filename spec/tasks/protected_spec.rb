require 'spec_helper'
require 'rake'

RSpec.describe 'protected rake task' do
  before(:all) { Rake.application.rake_require 'tasks/protected' }

  let :run_rake_task do
    Rake::Task[:protected].reenable
    Rake.application.invoke_task :protected
  end

  it 'raises an error in an environment that does not allow protected tasks' do
    expect(ENV).to receive('[]').with('STOP_PROTECTED_TASKS').and_return('true')

    expect { run_rake_task }.to raise_error('!!! This is a protected task and '\
      'this environment does not allow protected tasks. !!!')
  end

  context 'in a Heroku environment' do
    before :each do
      expect(ENV).to receive('[]').with('STOP_PROTECTED_TASKS')
    end

    it 'asks for confirmation of the app name and proceedes if it is correct' do
      expect(ENV).to receive('[]').with(
        'HEROKU_APP_NAME').and_return('app_name').twice
      expect(Tasks::Protected::Communicator).to receive(
        :get_app_name).and_return('app_name')

      expect { run_rake_task }.to_not raise_error
    end

    it 'raises an error if the provided app name is not correct' do
      expect(ENV).to receive('[]').with(
        'HEROKU_APP_NAME').and_return('app_name').twice
      expect(Tasks::Protected::Communicator).to receive(
        :get_app_name).and_return('not_a_real_app')

      expect { run_rake_task }.to raise_error 'You are attempting to apply '\
        'changes to the wrong environment, or you miss-typed the application '\
        'name.'
    end
  end
end
