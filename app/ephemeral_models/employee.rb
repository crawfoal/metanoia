class Employee
  attr_reader :email

  def initialize(email:, gym_id:)
    @email = email
    @gym_id = gym_id
  end

  def roles
    Employment.roles.select do |role_name|
      user.has_role?(role_name) &&
      Employment.exists?(
        role_story_id: user.send("#{role_name}_story").id,
        role_story_type: "#{role_name.to_s.camelize}Story",
        gym_id: @gym_id
      )
    end.to_sentence(two_words_connector: ', ', last_word_connector: ', ')
  end

  private

  def user
    @user ||= User.find_by_email(@email)
  end

end
