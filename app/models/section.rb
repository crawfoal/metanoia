class Section < ApplicationRecord
  include ExtractValue
  extract_value_from :name

  belongs_to :gym
  has_many :climbs
end
