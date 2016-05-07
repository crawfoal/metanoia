FactoryGirl.define do
  factory :section do
    before :create do |section|
      unless section.gym
        section.gym = create :gym
      end
    end

    trait :with_name do
      name "Gym Section"
    end
  end
end
