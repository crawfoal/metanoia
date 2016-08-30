FactoryGirl.define do
  factory :employment_form do
    initialize_with { new(attributes.merge(gym_id: gym.id)) }

    transient do
      gym { create :gym }
    end

    email { create(:user).email }
    role_name { Employment.roles.sample.to_s }

    trait :with_unregistered_email do
      email 'fake_address@example.com'
    end
  end
end
