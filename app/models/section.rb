class Section < ActiveRecord::Base
  include ExtractValue
  extract_value_from :name

  belongs_to :gym
  has_many :climbs
end
