require 'rails_helper'

RSpec.describe ClimbLogsTree do
  describe 'each' do
    it 'yields each gym, along with the "section branches" - i.e. a hash of '\
       'the sections pointing to an array of climbs logged in that section' do
      athlete = create :athlete
      boulder_gym = create :tiny_boulder_gym
      log_all_climbs(boulder_gym, athlete)
      route_gym = create :tiny_route_gym
      log_all_climbs(route_gym, athlete)

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
