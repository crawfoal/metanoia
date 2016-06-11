class Bucket < ActiveRecord::Base
  belongs_to :grade_system
  belongs_to :lower_bound_grade, class_name: 'Grade'
  belongs_to :upper_bound_grade, class_name: 'Grade'
  scope :ordered, -> { joins(:lower_bound_grade).order('grades.sequence_number') }
end
