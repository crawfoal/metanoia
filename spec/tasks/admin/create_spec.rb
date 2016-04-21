require 'rails_helper'
require 'rake'

RSpec.describe 'admin rake tasks' do
  before :all do
    Rake.application.rake_require 'tasks/admin/create'
    Rake::Task.define_task(:environment)
  end

  describe 'admin:create' do
    before do
      allow(Tasks::Admin::Communicator).to receive(
        :get_email).and_return('amanda@example.com')
      allow(Tasks::Admin::Communicator).to receive(:display_temporary_password)
    end

    let :run_rake_task do
      Rake::Task['admin:create'].reenable
      Rake.application.invoke_task 'admin:create'
    end

    it 'creates a user' do
      expect { run_rake_task }.to change { User.count }.by(1)
    end

    it 'uses the email specified at the command prompt' do
      expect(Tasks::Admin::Communicator).to receive(
        :get_email).and_return('amanda@example.com')
      run_rake_task
      user = User.last
      expect(user.email).to eq 'amanda@example.com'
    end

    it 'displays the temporary password in the terminal' do
      expect(Tasks::Admin::Communicator).to receive(
        :display_temporary_password).with(/.+/)
      run_rake_task
    end

    it 'assigns the new user a role of admin' do
      run_rake_task
      user = User.last
      expect(user).to have_role :admin
    end

    it 'raises an error if the email address is already taken' do
      create :user, email: 'amanda@example.com'
      expect { run_rake_task }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
