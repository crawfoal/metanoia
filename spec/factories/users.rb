FactoryGirl.define do
  ROLE_NAMES = [:admin, :athlete, :setter, :manager]

  sequence :email do |n|
    "user#{n}@example.com"
  end

  ROLE_NAMES.each do |role_name|
    sequence "#{role_name}_email".to_sym do |n|
      "#{role_name}#{n}@example.com"
    end
  end

  factory :user do
    email { generate :email }
    password 'password'
    password_confirmation { password }

    ROLE_NAMES.each do |role_name|
      factory role_name do
        email { generate "#{role_name}_email".to_sym }

        after :build do |user|
          user.add_role role_name
        end
      end
    end
  end
end
