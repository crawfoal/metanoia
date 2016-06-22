require 'task_helper'

RSpec.describe 'db:populate', type: :task do
  before :all do
    Rake::Task['db:fill'].reenable # prerequisite for db:populate
    run_rake_task 'db:populate'
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

  it 'some climbs have a grade' do
    expect(
      Climb.find_each.all? do |climb|
        climb.grade.name == '?'
      end
    ).to be_falsey
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
    DatabaseCleaner.strategy = DatabaseCleanerHelper.truncation_except_seeded_tables
    DatabaseCleaner.clean
  end
end
