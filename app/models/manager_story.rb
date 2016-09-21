class ManagerStory < ApplicationRecord
  include Employable
  belongs_to :user
end
