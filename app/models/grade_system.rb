class GradeSystem < ActiveRecord::Base
  has_many :grades
  validates_presence_of :name
end
