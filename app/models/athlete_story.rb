class AthleteStory < ApplicationRecord
  belongs_to :user
  validates_presence_of :user
  has_many :climb_logs
  has_many :memberships
  has_many :gyms, through: :memberships
end
