FactoryGirl.define do
  factory :climb_log do
    before :create do |climb_log|
      unless climb_log.athlete_story
        climb_log.athlete_story = create :athlete_story
      end

      unless climb_log.climb
        climb_log.climb = create :climb
      end
    end
  end
end
