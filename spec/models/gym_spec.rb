require 'rails_helper'

RSpec.describe Gym, type: :model do
  it { should have_many(:sections).dependent(:destroy).autosave(true) }
  it { should extract_value_from(:name, collections: :sections) }
  it { should have_many :memberships }
  it { should have_many :athlete_stories }
  it { should belong_to :route_grade_system }
  it { should belong_to :boulder_grade_system }

  it 'is invalid if `#value` is blank' do
    expect(Gym.new).to_not be_valid
  end

  describe '#route_grades' do
    it "returns a list of the names of the grades for the gym's "\
       '`route_grade_system`' do
      yds = GradeSystem.find_by_name! 'Yosemite'
      gym = create :gym, route_grade_system: yds
      expect(gym.route_grades).to eq yds.grades.map(&:name)
    end
  end

  describe '#boulder_grades' do
    it "returns a list of the names of the grades for the gym's "\
       '`boulder_grade_system`' do
      hueco = GradeSystem.find_by_name! 'Hueco'
      gym = create :gym, route_grade_system: hueco
      expect(gym.boulder_grades).to eq hueco.grades.map(&:name)
    end
  end
end
