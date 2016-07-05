class ManagerStory < ActiveRecord::Base
  include Employable
  belongs_to :user
end
