class Grade < ActiveRecord::Base
  belongs_to :grade_system
  validates_presence_of :name
  validates_presence_of :grade_system
  scope :ordered, -> { order(:sequence_number) }
  belongs_to :bucket
  has_many :climbs

  def self.null_object
    find(111)
  end
end
