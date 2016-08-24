class EmploymentForm < BaseForm
  attr_accessor :email, :role_name
  attr_reader :employment
  delegate :persisted?, to: :employment
  delegate :gym, to: :employment

  validates :email, presence: true
  validates :role_name, presence: true
  validate :role_name_must_be_whitelisted
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
    pull_in_employment_errors
    return form_errors
  end

  def to_partial_path
    'employments/form'
  end

  def to_employee
    Employee.new(email: email, gym_id: gym.id)
  end

  def submit_path
    url_helpers.gym_employments_path(gym)
  end

  # This allows us to have the `Employment.roles` list change while the
  # application is running (that is why I didn't use the built in inclusion
  # matcher). It allows means that it doesn't matter if this file is loaded
  # before the role story models (during eager loading).
  def role_name_must_be_whitelisted
    unless role_name.present? && Employment.roles.include?(role_name.to_sym)
      role_names_to_sentence = Employment.roles.to_sentence(
        two_words_connector: ' or ',
        last_word_connector: ', or '
      )
      errors.add(:role_name, "must be one of \"#{role_names_to_sentence}\"")
    end
  end

  private

  def apply_form_attributes_to_models
    return unless form_attributes_valid?
    associate_or_create_role_story
  end

  def pull_in_employment_errors
    form_errors.messages[:employment] = \
      employment.errors.full_messages.map(&:downcase)
  end

  def user
    @user ||= User.find_by_email @email
  end

  def associate_or_create_role_story
    user.add_role @role_name unless user.has_role? @role_name
    @employment.role_story = user.send(role_story_type.underscore)
  end

  def role_story_type
    "#{@role_name.camelize}Story"
  end
end
