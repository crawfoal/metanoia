class Gym < ActiveRecord::Base
  include ExtractValue
  extract_value_from :name, collections: :sections

  has_many :sections, dependent: :destroy
end
