class SetterStory < ApplicationRecord
  include Employable
  belongs_to :user
end
