class ManagerStory < ActiveRecord::Base
  belongs_to :user
  has_many :employments, as: :role_story
end
