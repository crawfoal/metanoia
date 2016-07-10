FactoryGirl.define do
  factory :employment do
    gym

    after :build do |employment|
      unless employment.role_story.present?
        employment.role_story = build(:setter).setter_story
      end
    end
  end
end
