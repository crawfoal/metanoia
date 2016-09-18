module Employable
  extend ActiveSupport::Concern

  Employment.class_eval do
    class << self
      attr_accessor :roles, :role_story_tables, :role_story_types
    end

    @roles = []
    @role_story_tables = []
    @role_story_types = []
  end

  included do
    has_many :employments, as: :role_story
    Employment.roles << table_name.match(/(.+)_stories$/)[1].to_sym
    Employment.role_story_tables << table_name
    Employment.role_story_types << name
  end

  # tested through User#employed_at?
  def employed_at?(gym)
    employments.exists?(gym_id: gym)
  end
end
