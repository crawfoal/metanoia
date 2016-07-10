class EmploymentForm < BaseForm
  attr_accessor :email, :role_name
  attr_reader :employment
  delegate :persisted?, to: :employment

  validates :email, presence: true
  validates :role_name, presence: true
  validates :user, presence: true

  def initialize(attribs = {})
    @email = attribs.delete(:email)
    @role_name = attribs.delete(:role_name)
    @employment = Employment.new(attribs)
  end

  alias_method :form_attributes_valid?, :valid?
  def valid?
    apply_form_attributes_to_models
    form_attributes_valid? && @employment.valid?
  end

  def persist!
    apply_form_attributes_to_models
    @employment.save!
  end

  alias_method :form_errors, :errors
  def errors
    form_errors.messages[:employment] = employment.errors.full_messages
    return form_errors
  end

  private

  def apply_form_attributes_to_models
    return unless form_attributes_valid?
    @employment.role_story = find_role_story
  end

  def user
    @user ||= User.find_by_email @email
  end

  def find_role_story
    user.send(role_story_type.underscore)
  end

  def role_story_type
    "#{@role_name.camelize}Story"
  end
end
