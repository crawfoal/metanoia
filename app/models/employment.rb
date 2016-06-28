class Employment < ActiveRecord::Base
  belongs_to :gym
  belongs_to :role_story, polymorphic: true

  delegate :user, to: :role_story, allow_nil: true

  ROLES = [:setter, :manager]
end
