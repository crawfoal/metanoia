class User < ActiveRecord::Base
  rolify after_add: :set_current_role_if_not_defined

  def set_current_role_if_not_defined(role)
    self.current_role ||= role.name
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
