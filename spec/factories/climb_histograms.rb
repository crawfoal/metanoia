FactoryGirl.define do
  factory :climb_histogram do
    initialize_with { new(climbs, grade_system) }
    skip_create

    transient do
      gym_factory :gym
      gym { create gym_factory }
      climb_type { 'boulder' }
      climbs { gym.send(climb_type.downcase.pluralize) }
      grade_system { gym.send("#{climb_type.downcase}_grade_system") }
    end

    trait :empty_stub do
      transient do
        gym nil
        climbs Climb.none
        grade_system { build_stubbed(:grade_system, :without_buckets) }
      end
    end
  end
end
