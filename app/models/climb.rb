class Climb < ApplicationRecord
  COLORS = {
    '#b71c1c' => 'Red',
    '#ec407a' => 'Pink',
    '#7b1fa2' => 'Purple',
    '#0d47a1' => 'Blue',
    '#00838f' => 'Teal',
    '#2e7d32' => 'Green',
    '#fdd835' => 'Yellow',
    '#ef6c00' => 'Orange',
    '#6d4c41' => 'Brown',
    '#000000' => 'Black',
    '#ffffff' => 'White'
  }.freeze

  validates_presence_of :type
  belongs_to :section
  validates_presence_of :section
  has_one :gym, through: :section
  belongs_to :grade
  before_save :set_grade_default_if_blank

  # The list of colors is duplicated here in order to ensure that the order used
  # in the enum declaration doesn't change. Once data has been entered in a
  # production environment, special care needs to be taken when adding new
  # options to a Rails enum definition. Either you can only add values to the
  # end of the array, or the production data needs to be migrated.
  enum color: [
    '#b71c1c', '#ec407a', '#7b1fa2', '#0d47a1', '#00838f', '#2e7d32',
    '#fdd835', '#ef6c00', '#6d4c41', '#000000', '#ffffff'
  ]

  def self.active
    where('teardown_date > ? OR teardown_date IS NULL', DateTime.now)
  end

  def self.color_name_for(hex_code)
    COLORS[hex_code].try(:downcase)
  end

  def color_name
    self.class.color_name_for(color)
  end

  # This is the default, however it makes the `Route` and `Boulder` classes use
  # the correct policy class through inheritance.
  def self.policy_class
    ClimbPolicy
  end

  protected

  def set_grade_default_if_blank
    self.grade = Grade.null_object unless grade.present?
  end
end
