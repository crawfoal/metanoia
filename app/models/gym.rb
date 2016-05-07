class Gym < ActiveRecord::Base
  include ExtractValue
  extract_value_from :name, collections: :sections

  has_many :sections, dependent: :destroy, autosave: true

  validate :value_cannot_be_blank
  def value_cannot_be_blank
    unless value(reject_blanks: true).present?
      errors.add(:base, 'Cannot create a empty record for a gym. '\
                        'You must define some information for the gym itself, '\
                        'or create some sections for the gym.')
    end
  end

  has_many :memberships
  has_many :athlete_stories, through: :memberships
end
