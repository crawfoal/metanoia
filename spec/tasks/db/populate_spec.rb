require 'rails_helper'
require 'rake'

top_level = self

RSpec.describe 'db:populate' do
  before :all do
    Rake.application.rake_require 'tasks/db/populate'
    Rake::Task.define_task(:environment)
    Rake::Task.define_task(:protected)
    Rake::Task.define_task('db:schema:load')
    Rake::Task.define_task('db:seed')
    Rake::Task.define_task('db:reset') # don't actually reset the db during test
  end

  def run_rake_task
    Rake::Task['db:populate'].reenable
    Rake.application.invoke_task 'db:populate'
  end

  context 'in a non-Heroku environment' do
    before :all do
      # We have to use truncation to clean up because DatabaseCleaner doesn't
      # supported nested transactions. If we open a transaction here and then
      # also for each example, it will rollback *both* open transactions after
      # the first example is run, and then the rest of the examples will fail.
      #
      # The strategy is set right before we clean in the `after :all` hook
      # because DatabaseCleaner only holds the current strategy, and the
      # examples below are still using the transaction strategy to go back to
      # the state right after the data was populated.
      run_rake_task
    end

    it 'creates the four gyms we have factories for, plus the sample gym' do
      expect(Gym.count).to eq 5
      [
        'Wild Walls',
        'Boulders Climbing Gym',
        'Movement - Boulder',
        'The Spot',
        'Gym Name'
      ].each do |name|
        expect(Gym.find_by_name(name)).to be_present
      end
    end

    it 'each gym has some sections' do
      Gym.find_each do |gym|
        expect(gym.sections.count).to be > 0
      end
    end

    it 'adds climbs to each section of each gym' do
      Gym.find_each do |gym|
        gym.sections.each do |section|
          expect(section.climbs.count).to be > 0
        end
      end
    end

    it 'creates a few admin users' do
      expect(User.with_role(:admin).count).to be > 0
    end

    it 'creates some users with no role' do
      users_with_no_role = User.includes(:users_roles).where(
        users_roles: { role_id: nil }
      )
      expect(users_with_no_role.count).to be > 0
    end

    after :all do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean
    end
  end

  context 'in a Heroku environment' do
    before :each do
      allow(ENV).to receive('[]').and_call_original
      allow(ENV).to receive('[]').with('HEROKU_APP_NAME').and_return('app_name')
      allow(Tasks::DB::Populate).to receive(:fill_database)
      allow(top_level).to receive(:system).with(
        'heroku pg:reset ENV["DATABASE_URL"]').and_return(true)
    end

    it 'does not invoke db:reset' do
      expect(Rake::Task['db:reset']).to_not receive(:invoke)
      run_rake_task
    end

    it 'executes `heroku pg:reset` and invokes db:schema:load and db:seed' do
      expect(top_level).to receive(:system).with(
        'heroku pg:reset ENV["DATABASE_URL"]').and_return(true)
      expect(Rake::Task['db:schema:load']).to receive(:invoke)
      expect(Rake::Task['db:seed']).to receive(:invoke)
      run_rake_task
    end

    it 'raises an error if `heroku pg:reset` fails' do
      expect(top_level).to receive(:system).with(
        'heroku pg:reset ENV["DATABASE_URL"]').and_return(false)
      expect { run_rake_task }.to raise_error 'heroku pg:reset failed... aborting'
    end
  end
end
