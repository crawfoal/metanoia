FactoryGirl.define do
  factory :wild_walls, parent: :gym do
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

  factory :boulders_climbing_gym, parent: :gym do
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

  factory :movement_boulder, parent: :gym do
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

  factory :the_spot, parent: :gym do
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
