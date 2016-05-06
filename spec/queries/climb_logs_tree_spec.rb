require 'rails_helper'

RSpec.describe ClimbLogsTree do
  describe 'each' do
    it 'yields each gym, along with the "section branches" - i.e. a hash of '\
       'the sections pointing to an array of climbs logged in that section' do
      gym1 = create :gym, :realistic
      athlete = create :athlete
      gym1.sections.each do |section|
        section.climbs.each do |climb|
          ClimbLogger.new({climb_id: climb.id}, athlete).log
        end
      end

      gym2 = create :gym, :with_name, :with_named_section
      climb = build :climb
      gym2.sections.first.climbs << climb
      gym2.save!
      ClimbLogger.new({climb_id: climb.id}, athlete).log

      climb_logs_tree = ClimbLogsTree.new(athlete.athlete_story)

      expect { |b| climb_logs_tree.each(&b) }.to yield_control.twice
      climb_logs_tree.each do |gym, sections|
        expect(gym).to be_instance_of Gym
        expect { |b| sections.each(&b) }.to \
          yield_control.exactly(gym.sections.count).times

        sections.each do |section, climb_logs|
          expect(section).to be_instance_of Section
          expect { |b| climb_logs.each(&b) }.to \
            yield_control.exactly(section.climbs.count).times
        end
      end
    end
  end
end
