class EmploymentForm < BaseForm
  delegate_basic_form_interface_methods to: :@employment
  attr_accessor :email, :role_name

  def initialize(attribs = {})
    @email = attribs.delete(:email)
    @role_name = attribs.delete(:role_name)
    @employment = Employment.new(attribs)
  end

  # the following two methods don't yet handle record updates (they require that
  # the email and role name are always given)
  def save
    return unless form_attributes_valid?
    @employment.role_story = find_role_story
    @employment.save
  end

  def valid?
    form_attributes_valid? && @employment.valid?
  end

  private

  def find_role_story
    user.send(role_story_type.underscore)
  end

  def user
    User.find_by_email @email
  end

  def role_story_type
    "#{@role_name.camelize}Story"
  end

  def form_attributes_valid?
    [@email, @role_name].all? &:present?
  end
end
