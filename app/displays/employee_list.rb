class EmployeeList
  attr_reader :gym
  delegate :name, to: :gym, prefix: true

  def initialize(gym)
    @gym = gym
  end

  def employees
    initialize_employees if @employees.blank?
    @employees.values
  end

  private

  def initialize_employees
    @employees = {}
    users_by_employment_role.each do |role_name, users|
      users.find_each do |user|
        create_or_update_employee(user, role_name)
      end
    end
  end

  def create_or_update_employee(user, role_name)
    if @employees[user.id].present?
      @employees[user.id].roles_in_words += ", #{role_name}"
    else
      @employees[user.id] = OpenStruct.new(
        email: user.email,
        roles_in_words: role_name.to_s
      )
    end
  end

  def users_by_employment_role
    Employable::RoleStories.role_names.collect do |role_name|
      [
        role_name,
        User.joins("#{role_name}_story": :employments).
          where(employments: { gym_id: @gym.id })
      ]
    end
  end
end
