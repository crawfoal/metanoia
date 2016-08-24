FactoryGirl.define do
  factory :employment do
    gym

    after :build do |employment|
      unless employment.role_story.present?
        employment.role_story = build(:setter).setter_story
      end
    end

    trait :without_role_story do
      after :build do |employment|
        employment.role_story = nil
      end
    end
  end
end
