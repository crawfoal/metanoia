class EmployeeListPolicy < ApplicationPolicy
  alias_method :employee_list, :record

  def index?
    Employee.new(email: user.email, gym_id: employee_list.gym.id).roles.any?
  end
end
