module Employable
  extend ActiveSupport::Concern

  included do
    has_many :employments, as: :role_story
    Employment.roles << table_name.match(/(.+)_stories$/)[1].to_sym
  end
end
