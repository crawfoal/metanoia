class EmploymentPolicy < ApplicationPolicy
  alias_method :employment, :record

  def create?
    user.current_role == 'manager' &&
      user.manager_story.employments.exists?(gym: employment.gym)
  end
end
