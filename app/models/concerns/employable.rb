module Employable
  extend ActiveSupport::Concern

  included do
    has_many :employments, as: :role_story
    Employment.roles << table_name.match(/(.+)_stories$/)[1].to_sym
  end

  # tested through User#employed_at?
  def employed_at?(gym)
    gym_id = gym.respond_to?(:id) ? gym.id : gym
    employments.exists?(gym_id: gym_id)
  end
end
