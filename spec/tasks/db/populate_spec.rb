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

  it 'creates a few setters' do
    expect(User.with_role(:setter).count).to be > 0
  end

  it 'creates a user with both admin and athlete roles' do
    expect(users_with_roles(:admin, :athlete).count).to be > 0
  end

  it 'creates some athlete users' do
    expect(User.with_role(:athlete).count).to be >
      users_with_roles(:admin, :athlete).count
  end

  it 'creates an athlete_story record for each athlete' do
    User.with_role(:athlete).each do |user|
      expect(user.athlete_story).to be_present
    end
  end

  it 'creates a user that is both a manager and setter' do
    expect(users_with_roles(:manager, :setter).count).to be > 0
  end

  it 'creates some users that are just managers' do
    expect(User.with_role(:manager).count).to be >
      users_with_roles(:manager, :setter).count
  end

  describe 'managers' do
    it 'have an associated employment record' do
      User.with_role(:manager).find_each do |user|
        expect(user.manager_story.employments).to_not be_blank
      end
    end
  end

  describe 'setters' do
    it 'have an associated employment record' do
      User.with_role(:setter).find_each do |user|
        expect(user.setter_story.employments).to_not be_blank
      end
    end
  end

  def users_with_roles(*role_names)
    role_names.reduce(User.with_role(role_names.shift)) do |result, role_name|
      result & User.with_role(role_name)
    end
  end

  after :all do
    DatabaseCleaner.strategy = DatabaseCleanerHelper.truncation_except_seeded_tables
    DatabaseCleaner.clean
  end
end
