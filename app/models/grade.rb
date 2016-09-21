class Grade < ApplicationRecord
  belongs_to :grade_system
  validates_presence_of :name
  validates_presence_of :grade_system
  scope :ordered, -> { order(:sequence_number) }
  belongs_to :bucket, optional: true
  has_many :climbs

  def self.null_object
    find(111)
  end
end
