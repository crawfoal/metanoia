require 'task_helper'

RSpec.describe 'admin rake tasks', type: :task do
  describe 'admin:create' do
    before :each do
      allow(Tasks::Admin::Communicator).to \
        receive(:get_email).and_return('admin@example.com')
      allow(Tasks::Admin::Communicator).to receive(:display_temporary_password)
    end

    it 'creates a user' do
      expect { run_rake_task('admin:create') }.to change { User.count }.by(1)
    end

    it 'uses the email specified at the command prompt' do
      allow(Tasks::Admin::Communicator).to \
        receive(:get_email).and_return('amanda@example.com')

      run_rake_task('admin:create')

      expect(User.last.email).to eq 'amanda@example.com'
    end

    it 'displays the temporary password in the terminal' do
      run_rake_task('admin:create')

      expect(Tasks::Admin::Communicator).to \
        have_received(:display_temporary_password).with(/.+/)
    end

    it 'assigns the new user a role of admin' do
      run_rake_task('admin:create')

      expect(User.last).to have_role :admin
    end

    it 'raises an error if the email address is already taken' do
      create :user, email: 'amanda@example.com'
      allow(Tasks::Admin::Communicator).to \
        receive(:get_email).and_return('amanda@example.com')

      expect { run_rake_task('admin:create') }.to \
        raise_error ActiveRecord::RecordInvalid
    end
  end
end
