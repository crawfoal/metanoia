class Employee
  attr_reader :email
  attr_accessor :roles

  def initialize(arg)
    @email = arg.try(:email) || arg[:email]
    @roles = arg.try(:role_name) || arg[:roles]
  end
end
