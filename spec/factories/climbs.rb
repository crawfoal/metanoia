FactoryGirl.define do
  factory :climb do
    type %w(Boulder Route).sample

    after :build do |climb|
      climb.grade = Grade.null_object
    end

    before :create do |climb|
      unless climb.section
        climb.section = create :section
      end
    end

    transient do
      grade_system nil
    end

    trait :not_active do
      teardown_date { Faker::Date.backward(1) }
    end

    trait :with_grade do
      after :build do |climb, evaluator|
        if evaluator.grade_system
          climb.grade = evaluator.grade_system.grades.sample
        elsif climb.gym
          climb_type = climb.type.downcase
          climb.grade = climb.gym.send("#{climb_type}_grades").sample
        else
          raise "Whoops... we can't set a grade if the climb isn't assigned to"\
                " a gym and you don't specify the grade system to be used."
        end
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
