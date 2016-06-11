require 'rails_helper'

RSpec.describe ClimbHistogram do
  describe '#data' do
    context "for a gym who's grade system specifies buckets" do
      let(:gym) { create :tiny_route_gym }
      let(:histogram) { ClimbHistogram.new(gym.routes, gym.route_grade_system) }

      it 'has the correct number of buckets' do
        expect(histogram.data.size).to eq gym.route_grade_system.buckets.count
      end

      it 'returns an array of bucket name and climb count pairs' do
        histogram.data.each do |bucket_name, count|
          expect(Bucket.find_by_name(bucket_name)).to be_present
        end
      end

      it 'includes all of the climbs' do
        total_count = histogram.data.map(&:last).reduce(&:+)
        expect(total_count).to eq Climb.count
      end
    end

    context "for a gym who's grade system doesn't specify buckets" do
      let(:gym) { create :rainbow_gym }
      let(:histogram) { ClimbHistogram.new(gym.boulders, gym.boulder_grade_system) }

      it "has data (the other tests aren't valid unless this passes)" do
        expect(gym.boulders.size).to be > 0
      end

      it 'has the correct number of buckets (number of associated grades, plus'\
         ' one for unspecified grades)' do
        expect(histogram.data.size).to eq gym.boulder_grade_system.grades.count + 1
      end

      it 'returns an array of grade name and route count pairs' do
        histogram.data.each do |grade_name, num_climbs|
          grade = Grade.find_by_name(grade_name)
          expect(grade).to be_present
          expect(Climb.where(grade_id: grade.id).count).to eq num_climbs
        end
      end

      it 'includes all of the climbs' do
        total_count = histogram.data.map(&:last).reduce(&:+)
        expect(total_count).to eq Climb.count
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
