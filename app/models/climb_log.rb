class ClimbLog < ActiveRecord::Base
  belongs_to :athlete_story
  validates_presence_of :athlete_story
  belongs_to :climb
  validates_presence_of :climb
end
