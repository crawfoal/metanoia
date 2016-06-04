class GradeSystem < ActiveRecord::Base
  has_many :grades, dependent: :destroy
  validates_presence_of :name
end
