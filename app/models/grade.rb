class Grade < ApplicationRecord
  belongs_to :grade_system
  validates_presence_of :name
  validates_presence_of :grade_system
  belongs_to :bucket, optional: true
  has_many :climbs

  scope :ordered, -> { order(:sequence_number) }

  def self.null_or_where(*args)
    where(*args).or(where(id: null_object_id))
  end

  def self.null_object
    find(null_object_id)
  end

  private
  def self.null_object_id
    111
  end
end
