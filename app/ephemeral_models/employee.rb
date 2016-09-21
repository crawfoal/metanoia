class Employee
  attr_reader :email

  def initialize(email:, gym_id:)
    @email = email
    @gym_id = gym_id
  end

  def roles_in_words
    roles.to_sentence(two_words_connector: ', ', last_word_connector: ', ')
  end

  def to_partial_path
    'employments/employee'
  end

  def roles
    Gym.find(@gym_id).employments.roles_for(user)
  end

  private

  def user
    @user ||= User.find_by_email(@email)
  end
end
