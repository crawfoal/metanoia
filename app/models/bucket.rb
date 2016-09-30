class Bucket < ApplicationRecord
  belongs_to :grade_system, counter_cache: true
  has_many :grades

  def self.ordered
    joins(:grades).group('buckets.id').order('MIN(grades.sequence_number)')
  end

  include HasNullObject
  null_object_id_is 17
end
