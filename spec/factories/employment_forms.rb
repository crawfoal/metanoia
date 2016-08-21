FactoryGirl.define do
  factory :employment_form do
    initialize_with { new(attributes.merge(gym_id: gym.id)) }

    transient do
      user { create :setter }
      gym { create :gym }
    end

    email { user.email }
    role_name { user.current_role }

    trait :with_unregistered_email do
      user nil
      email 'fake_address@example.com'
      role_name { Employment.roles.sample.to_s }
    end
  end
end
