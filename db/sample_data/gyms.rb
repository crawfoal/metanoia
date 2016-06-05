FactoryGirl.define do
  factory :sample_gym, parent: :gym do
    with_name

    transient do
      section_names (1..Faker::Number.between(4, 9)).map { |num| "Section #{num}" }
      climb_factory nil
    end

    after :build do |gym, evaluator|
      gym.sections.each do |section|
        climb_factory = evaluator.climb_factory || [:boulder, :route].sample

        section.climbs = build_list(
          climb_factory,
          Faker::Number.between(5, 15),
          :with_grade,
          :with_color,
          grade_system: gym.send("#{climb_factory}_grade_system")
        )
        section.climbs << build_list(
          climb_factory,
          Faker::Number.between(0, 3),
          :with_grade,
          grade_system: gym.send("#{climb_factory}_grade_system")
        )
        section.climbs << build_list(
          climb_factory,
          Faker::Number.between(0, 3),
          :with_color
        )
      end
    end
  end

  factory :wild_walls, parent: :sample_gym do
    name 'Wild Walls'
    transient do
      section_names [
        'The 45',
        'The Vert',
        'The Overhang',
        'The Back Wall',
        'The Slab',
        'Opposite Back Wall',
        'The Cave'
      ]
    end
  end

  factory :boulders_climbing_gym, parent: :sample_gym do
    name 'Boulders Climbing Gym'
    transient do
      section_names [
        'The 45',
        'The Vert',
        'The Overhang',
        'The Back Wall',
        'The Slab',
        'Opposite Back Wall',
        'The Cave'
      ]
    end
  end

  factory :movement_boulder, parent: :sample_gym do
    name 'Movement - Boulder'
    transient do
      section_names [
        'The Gray Wall',
        'The Gray Wall - Left',
        'The Gray Wall - Right',
        'The Back Wall',
        'The Back Corner',
        'The Slot',
        'The Arch'
      ]
    end
  end

  factory :the_spot, parent: :sample_gym do
    name 'The Spot'
    transient do
      section_names [
        'Left River',
        'Right River',
        'Font',
        'Left Dojo',
        'Right Dojo',
        'Back Scoop of the Hueco',
        'Back Right Hueco',
        'Big Front Scoop of the Hueco',
        'Small Scoop of the Hueco',
        'Left Beach',
        'Middle Meach',
        'Right Beach',
        'Yosemite'
      ]
    end
  end
end
