class SetterStory < ActiveRecord::Base
  include Employable
  belongs_to :user
end
