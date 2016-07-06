class Employment < ActiveRecord::Base
  belongs_to :gym

  belongs_to :role_story, polymorphic: true
  delegate :user, to: :role_story, allow_nil: true
  class << self; attr_accessor :roles; end
  @roles = []
  def role_name
    role_story_type.underscore.split('_story').first
  end
end
