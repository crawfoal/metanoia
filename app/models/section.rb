class Section < ActiveRecord::Base
  include ExtractValue
  extract_value_from :name

  belongs_to :gym
end
