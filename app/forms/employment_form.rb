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

  def valid?
    super && @employment.valid?
  end

  def persist!
    @employment.role_story = find_role_story
    @employment.save!
  end

  private

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
