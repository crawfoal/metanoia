class Bucket < ActiveRecord::Base
  belongs_to :grade_system
  scope :ordered, -> { joins(:grades).group('buckets.id').select('buckets.*', 'min(grades.sequence_number) as sn').order('sn') }
  has_many :grades
end
