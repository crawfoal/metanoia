FactoryGirl.define do
  factory :climb_logger do
    initialize_with { new(climb_log_params, user) }
    skip_create

    transient do
      climb_log_params { { climb_id: create(:climb).id } }
      user { create :athlete }
    end

    trait :with_invalid_climb_log_params do
      transient do
        climb_log_params { {} }
      end
    end

    trait :user_is_already_a_member_at_gym do
      after :build do |climb_logger, evaluator|
        gym = climb_logger.send(:gym)
        climb = create :climb, section: gym.sections.first
        climb_logger = build :climb_logger,
                             climb_log_params: { climb_id: climb.id },
                             user: evaluator.user
        climb_logger.log
      end
    end
  end
end
