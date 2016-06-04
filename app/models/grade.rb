class Grade < ActiveRecord::Base
  belongs_to :grade_system
  validates_presence_of :name
  validates_presence_of :grade_system
  default_scope { order(:sequence_number) }

  def self.null_object
    find(111)
  end
end
