class Employment < ActiveRecord::Base
  belongs_to :gym
  validates_presence_of :gym

  belongs_to :role_story, polymorphic: true
  validates_presence_of :role_story
  delegate :user, to: :role_story, allow_nil: true
  class << self; attr_accessor :roles; end
  @roles = []
  def role_name
    role_story_type.underscore.split('_story').first
  end
end
