class Employee
  attr_reader :email

  def initialize(email:, gym_id:)
    @email = email
    @gym_id = gym_id
  end

  def roles
    Employment.roles.select do |role_name|
      user.employed_at? @gym_id, with_role: role_name
    end.to_sentence(two_words_connector: ', ', last_word_connector: ', ')
  end

  def to_partial_path
    'employments/employee'
  end

  private

  def user
    @user ||= User.find_by_email(@email)
  end
end
