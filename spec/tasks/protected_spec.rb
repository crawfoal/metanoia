require 'task_helper'

RSpec.describe 'protected rake task', type: :task do
  it 'raises an error in an environment that does not allow protected tasks' do
    allow(ENV).to receive('[]').with('STOP_PROTECTED_TASKS').and_return('true')

    expect { run_rake_task(:protected) }.to \
      raise_error('!!! This is a protected task and this environment does not '\
      'allow protected tasks. !!!')
  end

  context 'in a Heroku environment' do
    before :each do
      allow(ENV).to receive('[]').with('STOP_PROTECTED_TASKS')
    end

    it 'asks for confirmation of the app name and proceedes if it is correct' do
      allow(ENV).to receive('[]').with(
        'HEROKU_APP_NAME').and_return('app_name')
      allow(Tasks::Protected::Communicator).to receive(
        :get_app_name).and_return('app_name')

      expect { run_rake_task(:protected) }.to_not raise_error
    end

    it 'raises an error if the provided app name is not correct' do
      allow(ENV).to receive('[]').with(
        'HEROKU_APP_NAME').and_return('app_name')
      allow(Tasks::Protected::Communicator).to receive(
        :get_app_name).and_return('not_a_real_app')

      expect { run_rake_task(:protected) }.to \
        raise_error 'You are attempting to apply changes to the wrong '\
                    'environment, or you miss-typed the application name.'
    end
  end
end
