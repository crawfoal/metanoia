FactoryGirl.define do
  factory :climb do
    type ['Boulder', 'Route'].sample
    section

    trait :with_grade do
      grade { type.constantize.grades.keys.sample }
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
