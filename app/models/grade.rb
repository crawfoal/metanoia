class Grade < ActiveRecord::Base
  belongs_to :grade_system
  validates_presence_of :name
  validates_presence_of :grade_system
end
