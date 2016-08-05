require 'rails_helper'

RSpec.describe Gym, type: :model do
  it { should have_many(:sections).dependent(:destroy).autosave(true) }
  it { should extract_value_from(:name, collections: :sections) }
  it { should have_many :memberships }
  it { should have_many :athlete_stories }
  it { should belong_to :route_grade_system }
  it { should belong_to :boulder_grade_system }
  it { should have_many :employments }

  it do
    should delegate_method(:grades).to(:route_grade_system).with_prefix(:route)
  end

  it do
    should delegate_method(:grades).to(
      :boulder_grade_system).with_prefix(:boulder)
  end

  it 'is invalid if `#value` is blank' do
    expect(Gym.new).to_not be_valid
  end

  describe '#routes' do
    it 'returns all the routes for each section in the gym' do
      trg = create :tiny_route_gym
      expect(trg.routes.count).to eq \
        trg.sections.map(&:climbs).map(&:count).reduce(&:+)
      expect(trg.routes.first).to be_a Climb
    end
  end

  describe '#boulders' do
    it 'returns all the boulders for each section in the gym' do
      tbg = create :tiny_boulder_gym
      expect(tbg.boulders.count).to eq \
        tbg.sections.map(&:climbs).map(&:count).reduce(&:+)
      expect(tbg.boulders.first).to be_a Climb
    end
  end
end
