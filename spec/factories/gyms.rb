module GymFactoryHelper
  def self.build_sections_if_empty(gym, evaluator)
    return unless gym.sections.empty?
    evaluator.section_names.each do |section_name|
      gym.sections << FactoryGirl.build(:section, name: section_name)
    end
  end

  def self.create_employees(gym, evaluator)
    evaluator.num_employees.times do
      FactoryGirl.create Employment.roles.sample, employed_at: gym
    end
  end
end

FactoryGirl.define do
  factory :gym do
    transient do
      section_names []
      num_employees 0
    end

    after :build do |gym, evaluator|
      gym.route_grade_system ||= GradeSystem.find_by_name! 'Yosemite'
      gym.boulder_grade_system ||= GradeSystem.find_by_name! 'Hueco'
      GymFactoryHelper.build_sections_if_empty(gym, evaluator)
    end

    before :create do |gym|
      if gym.value.blank?
        gym.name = 'Gym Name'
      end
    end

    after :create do |gym, evaluator|
      GymFactoryHelper.create_employees(gym, evaluator)
    end

    trait :with_name do
      name 'Gym Name'
    end

    trait :with_named_section do
      section_names ['Section Name']
    end

    trait :with_detailed_boulders do
      after :build do |gym, evaluator|
        GymFactoryHelper.build_sections_if_empty(gym, evaluator)
        gym.sections.each do |section|
          section.climbs = build_list(
            :boulder,
            3,
            :with_grade,
            :with_color,
            grade_system: gym.boulder_grade_system
          )
        end
      end
    end

    trait :with_detailed_routes do
      after :build do |gym, evaluator|
        GymFactoryHelper.build_sections_if_empty(gym, evaluator)
        gym.sections.each do |section|
          section.climbs = build_list(
            :route,
            3,
            :with_grade,
            :with_color,
            grade_system: gym.route_grade_system
          )
        end
      end
    end

    factory :tiny_boulder_gym do
      name 'Tiny Boulder Gym'
      section_names ['The Slab', 'The Cave', 'The 45']
      with_detailed_boulders
    end

    factory :rainbow_gym do
      name 'Rainbow Gym'
      boulder_grade_system { GradeSystem.find_by_name('Rainbow Scale') }
      section_names ['Bouldering Area']
      with_detailed_boulders
    end

    factory :tiny_route_gym do
      name 'Tiny Route Gym'
      section_names ['The Steep', 'The Dihedral', 'The Vert']
      with_detailed_routes
    end
  end
end
