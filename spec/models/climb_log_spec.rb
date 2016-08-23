require 'rails_helper'

RSpec.describe ClimbLog, type: :model do
  it { should belong_to :athlete_story }
  it { should belong_to :climb }
  it { should validate_presence_of :athlete_story  }
  it { should validate_presence_of :climb  }
  it { should respond_to :color }
  it { should respond_to :grade }
  it { should respond_to :color_name }

  describe '#in_section' do
    it 'should return all climb logs in the given section' do
      section = create :section
      athlete = create :athlete
      create_list :climb_log,
                  2,
                  climb: create(:climb, section: section),
                  athlete_story: athlete.athlete_story

      expect(athlete.athlete_story.climb_logs.in_section(section).size).to eq 2
    end
  end
end
