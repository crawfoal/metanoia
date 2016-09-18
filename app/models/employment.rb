class Employment < ActiveRecord::Base
  belongs_to :gym
  validates_presence_of :gym

  belongs_to :role_story, polymorphic: true
  validates_presence_of :role_story
  delegate :user, to: :role_story, allow_nil: true
  def role_name
    Employable::RoleStories.type_to_role_name(role_story_type)
  end

  def self.roles_for(user)
    Employable::RoleStories.types_to_role_names(
      for_user(user).pluck(:role_story_type)
    )
  end

  def self.for_user(user)
    user_id = user.try(:id) || user
    conditions = "#{Employable::RoleStories.tables.first}.user_id = #{user_id}"
    conditions =
      Employable::RoleStories.tables[1..-1].
        inject(conditions) do |conditions, table_name|
          conditions + " OR #{table_name}.user_id = #{user_id}"
        end
    with_role_stories.where(conditions)
    # once upgraded to Rails 5, do something like this:
    # with_role_stories.merge(Employable::RoleStories.for_user(user))
  end

  def self.with_role_stories
    send_chain(*(
      Employable::RoleStories.tables_and_types.map do |table_name, type|
        [:joins, <<-SQL]
          LEFT JOIN #{table_name}
          ON employments.role_story_id = #{table_name}.id
          AND employments.role_story_type = '#{type}'
        SQL
      end
    ))
  end
end
