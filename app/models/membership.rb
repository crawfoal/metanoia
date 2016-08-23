class Membership < ActiveRecord::Base
  belongs_to :athlete_story
  belongs_to :gym
  # This table is intended to have a "classification" column (or something like
  # that) at some point, that would indicate if the athlete has a monthly
  # membership, punch card, is just a day pass user, etc. It isn't intended to
  # represent only users who have an actual membership in the sense that gyms
  # use this term, but rather it is just saying that a user has been to the gym
  # before.
end
