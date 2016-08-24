FactoryGirl.define do
  factory :grade_system do
    skip_create # the table `grade_systems` should only have seeded records

    name 'Factory Grade System'

    trait :without_buckets do
      # this is the default for now
    end
  end
end
