FactoryGirl.define do
  factory :gym do
    transient do
      section_names []
    end

    after :build do |gym, evaluator|
      evaluator.section_names.each do |section_name|
        gym.sections << build(:section, name: section_name)
      end
    end

    before :create do |gym|
      if gym.value.blank?
        gym.name = 'Gym Name'
      end
    end

    trait :with_name do
      name 'Gym Name'
    end

    trait :with_named_section do
      section_names ['Section Name']
    end
  end
end
