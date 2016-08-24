FactoryGirl.define do
  role_names = [:admin, :athlete, :setter, :manager].freeze

  sequence :email do |n|
    "user#{n}@example.com"
  end

  role_names.each do |role_name|
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
        roles.pluck(:name).map do |role_name|
          send("#{role_name.underscore}_story")
        end
      end

      employer_gym do
        if !employed_at.present?
          nil
        elsif employed_at.respond_to? :employments
          employed_at
        else
          Gym.where(employed_at).first
        end
      end
    end

    after :create do |user, evaluator|
      if evaluator.employer_gym.present?
        evaluator.employment_role_stories.each do |role_story|
          if user.persisted?
            evaluator.employer_gym.employments.create(role_story: role_story)
          else # TODO: I don't think this every actually runs...
            evaluator.employer_gym.employments.build(role_story: role_story)
          end
        end
      end
    end

    role_names.each do |role_name|
      factory role_name do
        email { generate "#{role_name}_email".to_sym }

        transient do
          other_roles nil
        end

        after :build do |user, evaluator|
          user.add_role role_name
          Array(evaluator.other_roles).each do |role_name|
            user.add_role role_name
          end
        end
      end
    end
  end

  factory :visitor do
    skip_create
  end
end
