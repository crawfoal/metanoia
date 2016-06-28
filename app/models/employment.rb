class Employment < ActiveRecord::Base
  belongs_to :gym
  belongs_to :role_story, polymorphic: true

  delegate :user, to: :role_story, allow_nil: true

  attr_writer :email, :role_name

  ROLES = [:setter]

  before_save :associate_user

  def email
    @email || user.try(:email)
  end

  def role_name
    @role_name || parse_out_role_name
  end

  private

  def associate_user
    return unless email.present? && role_name.present?
    return unless role_story.blank? || (email_changed? || role_name_changed?)
    self.role_story = User.find_by_email(email).send("#{role_name}_story")
  end

  def email_changed?
    @email.present? && (@email != user.try(:email))
  end

  def role_name_changed?
    @role_name.present? && (@role_name != parse_out_role_name)
  end

  def parse_out_role_name
    return '' unless role_story_type
    role_story_type.underscore[/^(.*)_story$/, 1]
  end
end
