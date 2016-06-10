require 'rails_helper'

RSpec.describe ClimbHistogram do
  describe '#data' do
    it 'returns an array of grade name and route count pairs and includes all '\
       'of the routes in the gym' do
      trg = create :tiny_route_gym

      rh = ClimbHistogram.new(trg.routes, trg.route_grade_system)
      rh_data = rh.data

      expect(rh_data.size).to be > 0
      rh_data.each do |grade_name, num_climbs|
        grade = Grade.find_by_name(grade_name)
        expect(grade).to be_present
        expect(Climb.where(grade_id: grade.id).count).to eq num_climbs
      end
    end

    context "for a gym who's grade system specifies buckets" do
      xit 'has the correct number of buckets' do
        trg = create :tiny_route_gym

        rh = ClimbHistogram.new(trg.routes, trg.route_grade_system)
        rh_data = rh.data

        expect(rh_data.size).to eq trg.route_grade_system.buckets.count
      end
    end

    context "for a gym who's grade system doesn't specify buckets" do
      it 'has the correct number of buckets (number of associated grades, plus'\
         ' one for unspecied grades)' do
        rbg = create :rainbow_gym

        rh = ClimbHistogram.new(rbg.boulders, rbg.boulder_grade_system)
        rh_data = rh.data

        expect(rh_data.size).to eq rbg.boulder_grade_system.grades.count + 1
      end
    end
  end

  describe '#has_data?' do
    it 'returns a falsey value if there are no routes in the given relation' do
      tbg = create :tiny_boulder_gym
      rh = ClimbHistogram.new(tbg.routes, tbg.boulder_grade_system)
      expect(rh.has_data?).to be_falsey
    end

    it 'returns a truthy value if there are routes in the given relation' do
      trg = create :tiny_route_gym
      rh = ClimbHistogram.new(trg.routes, trg.route_grade_system)
      expect(rh.has_data?).to be_truthy
    end
  end
end
