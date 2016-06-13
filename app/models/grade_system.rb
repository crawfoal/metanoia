class GradeSystem < ActiveRecord::Base
  has_many :grades, dependent: :destroy
  validates_presence_of :name
  has_many :buckets

  def has_buckets?
    !buckets.empty?
  end
end
