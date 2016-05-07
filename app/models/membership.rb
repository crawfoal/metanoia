class Membership < ActiveRecord::Base
  belongs_to :athlete_story
  belongs_to :gym
end
