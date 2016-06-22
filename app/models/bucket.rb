class Bucket < ActiveRecord::Base
  belongs_to :grade_system
  has_many :grades

  def self.ordered
    joins(:grades).
      group('buckets.id').
      select('buckets.*', 'min(grades.sequence_number) as sn').
      order('sn')
  end
end
