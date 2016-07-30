class User < ActiveRecord::Base
  rolify after_add: :rolify_after_add

  def rolify_after_add(role)
    set_current_role_if_not_defined(role)
    build_or_create_story(role.name)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :athlete_story
  has_one :setter_story
  has_one :manager_story

  def employed_at?(gym, with_role:)
    has_role?(with_role) && send("#{with_role}_story").employed_at?(gym)
  end

  private

  def set_current_role_if_not_defined(role)
    unless current_role
      self.current_role = role.name
      save
    end
    self.current_role ||= role.name
  end

  def build_or_create_story(role_name)
    if persisted?
      try("create_#{role_name}_story")
    else
      try("build_#{role_name}_story")
    end
  end
end
