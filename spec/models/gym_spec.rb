require 'rails_helper'

RSpec.describe Gym, type: :model do
  it { should have_many(:sections).dependent(:destroy).autosave(true) }
  it { should extract_value_from(:name, collections: :sections) }
  it { should have_many :memberships }
  it { should have_many :athlete_stories }
  it { should belong_to :route_grade_system }
  it { should belong_to :boulder_grade_system }
  it { should delegate_method(:grades).to(:route_grade_system).with_prefix(:route) }
  it { should delegate_method(:grades).to(:boulder_grade_system).with_prefix(:boulder) }

  it 'is invalid if `#value` is blank' do
    expect(Gym.new).to_not be_valid
  end
end
