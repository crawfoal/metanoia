require 'rails_helper'
require 'rake'

RSpec.describe 'db:populate' do
  before :all do
    Rake.application.rake_require 'tasks/db/populate'
    Rake::Task.define_task(:environment)
    Rake::Task.define_task(:protected)
    Rake::Task.define_task('db:reset') # don't actually reset the db during test

    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
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
      expect(Gym.find_by_name name).to be_present
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

  after :all do
    DatabaseCleaner.clean
  end
end
