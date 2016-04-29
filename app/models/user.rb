class User < ActiveRecord::Base
  rolify after_add: :rolify_after_add

  def rolify_after_add(role)
    set_current_role_if_not_defined(role)
    if role.name == 'athlete'
      persisted? ? create_athlete_story : build_athlete_story
    end
  end

  def set_current_role_if_not_defined(role)
    unless current_role
      self.current_role = role.name
      save
    end
    self.current_role ||= role.name
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :athlete_story
end
