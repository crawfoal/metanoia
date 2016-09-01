class Bucket < ActiveRecord::Base
  belongs_to :grade_system
  has_many :grades

  def self.ordered
    joins(:grades).group('buckets.id').order('MIN(grades.sequence_number)')
  end

  def self.null_object
    find(17)
  end
end
