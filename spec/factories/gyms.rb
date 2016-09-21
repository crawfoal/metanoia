FactoryGirl.define do
  factory :gym do
    transient do
      section_names []
      num_employees 0
    end

    after :build do |gym|
      def gym.build_sections(evaluator)
        evaluator.section_names.each do |section_name|
          sections << FactoryGirl.build(:section, name: section_name)
        end
      end

      def gym.build_detailed_climbs(climb_type)
        sections.each do |section|
          section.climbs = FactoryGirl.build_list(
            climb_type,
            3,
            :with_grade,
            :with_color,
            grade_system: send("#{climb_type}_grade_system")
          )
        end
      end
    end

    after :build do |gym, evaluator|
      gym.route_grade_system ||= GradeSystem.find_by_name! 'Yosemite'
      gym.boulder_grade_system ||= GradeSystem.find_by_name! 'Hueco'
      gym.build_sections(evaluator) if gym.sections.empty?
    end

    before :create do |gym|
      # there is a validation that checks to see if all attributes are blank
      if gym.value.blank?
        gym.name = 'Gym Name'
      end
    end

    after :create do |gym, evaluator|
      evaluator.num_employees.times do
        FactoryGirl.create(
          Employable::RoleStories.role_names.sample,
          employed_at: gym
        )
      end
    end

    trait :with_name do
      name 'Gym Name'
    end

    trait :with_named_section do
      section_names ['Section Name']
    end

    trait :with_detailed_boulders do
      after :build do |gym, evaluator|
        gym.build_sections(evaluator) if gym.sections.empty?
        gym.build_detailed_climbs(:boulder)
      end
    end

    trait :with_detailed_routes do
      after :build do |gym, evaluator|
        gym.build_sections(evaluator) if gym.sections.empty?
        gym.build_detailed_climbs(:route)
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
