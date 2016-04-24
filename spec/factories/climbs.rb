FactoryGirl.define do
  factory :climb do
    type %w(Boulder Route).sample

    before :create do |climb|
      unless climb.section
        climb.section = create :section
      end
    end

    trait :with_grade do
      grade { type.constantize.grades.values.sample }
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
