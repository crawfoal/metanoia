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

    transient do
      employed_at nil # only supports one place of employment for now
      employment_role_stories do
        roles.pluck(:name).keep_if do |role_name|
          Employment.roles.include? role_name.to_sym
        end.map do |role_name|
          send("#{role_name.underscore}_story")
        end
      end
    end

    after :create do |user, evaluator|
      gym = if evaluator.employed_at.respond_to? :employments
        evaluator.employed_at
      else
        Gym.where(evaluator.employed_at).first
      end
      if evaluator.employed_at.present? && gym.present?
        evaluator.employment_role_stories.each do |role_story|
          if user.persisted?
            gym.employments.create(role_story: role_story)
          else
            gym.employments.build(role_story: role_story)
          end
        end
      end
    end

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
