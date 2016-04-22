FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email { generate :email }
    password 'password'
    password_confirmation { password }

    factory :admin do
      after :build do |user|
        user.add_role :admin
      end
    end
  end
end
