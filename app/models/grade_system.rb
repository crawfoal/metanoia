class GradeSystem < ActiveRecord::Base
  has_many :grades, -> { order(:order) }, dependent: :destroy
  validates_presence_of :name
end
