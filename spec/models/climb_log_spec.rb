require 'rails_helper'

RSpec.describe ClimbLog, type: :model do
  it { should belong_to :athlete_story }
  it { should belong_to :climb }
  it { should validate_presence_of :athlete_story  }
  it { should validate_presence_of :climb  }
  it { should respond_to :color }
  it { should respond_to :grade }

  describe '#in_section' do
    it 'should return all climb logs in the given section' do
      climb1 = create :climb
      section = climb1.section
      climb2 = create :climb, section: section

      athlete = create :athlete
      ClimbLogger.new({ climb_id: climb1.id }, athlete).log
      ClimbLogger.new({ climb_id: climb2.id }, athlete).log

      expect(athlete.athlete_story.climb_logs.in_section(section).size).to eq 2
    end
  end
end
