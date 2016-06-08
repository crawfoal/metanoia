require 'rails_helper'

RSpec.describe RouteHistogram do
  describe '#data' do
    it 'returns an array of grade name and route count pairs' do
      trg = create :tiny_route_gym

      rh = RouteHistogram.new(trg.routes)
      rh_data = rh.data

      expect(rh_data.size).to be > 0
      rh_data.each do |grade_name, num_climbs|
        grade = Grade.find_by_name(grade_name)
        expect(grade).to be_present
        expect(Climb.where(grade_id: grade.id).count).to eq num_climbs
      end
    end
  end

  describe '#has_data?' do
    it 'returns a falsey value if there are no routes in the given relation' do
      tbg = create :tiny_boulder_gym
      rh = RouteHistogram.new(tbg.routes)
      expect(rh.has_data?).to be_falsey
    end

    it 'returns a truthy value if there are routes in the given relation' do
      trg = create :tiny_route_gym
      rh = RouteHistogram.new(trg.routes)
      expect(rh.has_data?).to be_truthy
    end
  end
end
