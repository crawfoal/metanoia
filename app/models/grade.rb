class Grade < ApplicationRecord
  belongs_to :grade_system
  validates_presence_of :name
  validates_presence_of :grade_system
  belongs_to :bucket, optional: true
  has_many :climbs

  scope :ordered, -> { order(:sequence_number) }

  include HasNullObject
  null_object_id_is 111
end
