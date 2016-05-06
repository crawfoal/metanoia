module GymFactoryHelper
  def self.build_sections_if_empty(gym, evaluator)
    return unless gym.sections.size == 0
    evaluator.section_names.each do |section_name|
      gym.sections << FactoryGirl.build(:section, name: section_name)
    end
  end
end

FactoryGirl.define do
  factory :gym do
    transient do
      section_names []
    end

    after :build do |gym, evaluator|
      GymFactoryHelper.build_sections_if_empty gym, evaluator
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

    trait :with_named_sections do
      section_names ['Section 1', 'Section 2', 'Section 3']
    end

    trait :realistic do
      with_named_sections

      after :build do |gym, evaluator|
        GymFactoryHelper.build_sections_if_empty gym, evaluator
        gym.sections.each do |section|
          type = ['Boulder', 'Route'].sample
          section.climbs = create_list(
            :climb,
            3,
            :with_grade,
            :with_color,
            type: type
          )
        end
      end
    end
  end
end
