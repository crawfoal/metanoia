class Bucket < ApplicationRecord
  belongs_to :grade_system, counter_cache: true
  has_many :grades

  def self.null_or_where(*args)
    where(*args).or(where(id: null_object_id))
  end

  def self.ordered
    joins(:grades).group('buckets.id').order('MIN(grades.sequence_number)')
  end

  def self.null_object
    find(null_object_id)
  end

  private
  def self.null_object_id
    17
  end
end
