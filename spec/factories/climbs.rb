FactoryGirl.define do
  factory :climb do
    type %w(Boulder Route).sample

    before :create do |climb|
      unless climb.section
        climb.section = create :section
      end
    end

    trait :with_grade do
      after :create do |climb|
        climb_type = climb.type.downcase
        climb.grade = climb.gym.send("#{climb_type}_grade_system").grades.sample
        climb.save!
      end
    end

    trait :with_color do
      color { Climb.colors.keys.sample }
    end

    factory :boulder do
      type 'Boulder'
    end

    factory :route do
      type 'Route'
    end
  end
end
