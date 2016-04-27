FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  sequence :admin_email do |n|
    "admin#{n}@example.com"
  end

  factory :user do
    email { generate :email }
    password 'password'
    password_confirmation { password }

    factory :admin do
      email { generate :admin_email }

      after :build do |user|
        user.add_role :admin
      end
    end

    factory :athlete do
      email { generate :email }

      after :build do |user|
        user.add_role :athlete
      end
    end
  end
end
