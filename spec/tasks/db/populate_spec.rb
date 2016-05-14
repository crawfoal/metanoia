require 'rails_helper'
require 'rake'

top_level = self

RSpec.describe 'db:populate', type: :task do
  before :all do
    Rake.application.rake_require 'tasks/db/populate'
    Rake::Task.define_task(:environment)
    Rake::Task.define_task(:protected)
    Rake::Task.define_task('db:reset') # don't actually reset the db during test
  end

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
    Rake::Task['db:populate'].reenable
    Rake::Task['db:fill'].reenable
    Rake.application.invoke_task 'db:populate'
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

  it 'creates a user with both admin and athlete roles' do
    expect((User.with_role(:admin) & User.with_role(:athlete)).count).to be > 0
  end

  it 'creates some athlete users' do
    expect(User.with_role(:athlete).count).to be >
      (User.with_role(:admin) & User.with_role(:athlete)).count
  end

  it 'creates an athlete_story record for each athlete' do
    User.with_role(:athlete).each do |user|
      expect(user.athlete_story).to be_present
    end
  end

  after :all do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end
end
