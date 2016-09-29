require 'rails_helper'

RSpec.describe ClimbHistogram do
  describe '#data' do
    context "for a gym who's grade system specifies buckets" do
      it 'returns an array of bucket name and climb count pairs' do
        histogram = build :climb_histogram,
                          gym_factory: :tiny_route_gym, climb_type: 'route'

        histogram.data.each do |bucket_name, _count|
          expect(Bucket.find_by_name(bucket_name)).to be_present
        end
      end

      it 'includes all of the climbs (including those with no grade)' do
        gym = create :tiny_route_gym
        histogram = build :climb_histogram, gym: gym, climb_type: 'route'
        create :route, section: gym.sections.first, grade: Grade.null_object

        total_count = histogram.data.map(&:last).reduce(&:+)
        expect(total_count).to eq Climb.count
      end

      it 'includes all buckets, in order' do
        gym = create :tiny_route_gym
        histogram = build :climb_histogram, gym: gym, climb_type: 'route'

        expect(histogram.data.map(&:first)).to eq \
          ['?'] + Bucket.
            from(gym.route_grade_system.buckets.ordered, :buckets).
            pluck(:name)
      end
    end

    context "for a gym who's grade system doesn't specify buckets" do
      it "has data (the other tests aren't valid unless this passes)" do
        histogram = build :climb_histogram,
                          gym_factory: :rainbow_gym, climb_type: 'boulder'

        expect(histogram).to have_data
      end

      it 'has one bucket for each associated grades, plus one for unspecified '\
         'grades' do
        gym = create :rainbow_gym
        histogram = build :climb_histogram, gym: gym, climb_type: 'boulder'

        expect(histogram.data.size).to eq \
          gym.boulder_grade_system.grades.count + 1
      end

      it 'has the grades ordered by sequence number' do
        gym = create :rainbow_gym
        histogram = build :climb_histogram, gym: gym, climb_type: 'boulder'

        expect(histogram.data.map(&:first)).to eq \
          ['?'] + Grade.from(gym.boulder_grade_system.grades.ordered, :grades).
            pluck(:name)
      end

      it 'returns an array of grade name and climb count pairs' do
        histogram = build :climb_histogram,
                          gym_factory: :rainbow_gym, climb_type: 'boulder'

        histogram.data.each do |grade_name, num_climbs|
          grade = Grade.find_by_name(grade_name)
          expect(grade).to be_present
          expect(Climb.where(grade_id: grade.id).count).to eq num_climbs
        end
      end

      it 'includes all of the climbs' do
        histogram = build :climb_histogram,
                          gym_factory: :rainbow_gym, climb_type: 'boulder'

        total_count = histogram.data.map(&:last).reduce(&:+)
        expect(total_count).to eq Climb.count
      end
    end
  end

  describe '#has_data?' do
    it 'returns a falsey value if there are no routes in the given relation' do
      histogram = build :climb_histogram,
                        gym_factory: :tiny_boulder_gym, climb_type: 'route'

      expect(histogram.has_data?).to be_falsey
    end

    it 'returns a truthy value if there are routes in the given relation' do
      histogram = build :climb_histogram,
                        gym_factory: :tiny_route_gym, climb_type: 'route'

      expect(histogram.has_data?).to be_truthy
    end
  end
end
