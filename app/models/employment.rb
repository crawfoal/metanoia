class Employment < ActiveRecord::Base
  belongs_to :gym
  validates_presence_of :gym

  belongs_to :role_story, polymorphic: true
  validates_presence_of :role_story
  delegate :user, to: :role_story, allow_nil: true
  def role_name
    self.class.role_story_type_to_name(role_story_type)
  end

  def self.role_story_type_to_name(type)
    type.underscore.split('_story').first
  end

  def self.role_story_types_to_names(types)
    types.map { |type| role_story_type_to_name(type) }
  end

  def self.roles_for(user)
    role_story_types_to_names(for_user(user).pluck(:role_story_type))
  end

  def self.for_user(user)
    user_id = user.try(:id) || user
    conditions = "#{role_story_tables.first}.user_id = #{user_id}"
    conditions =
      role_story_tables[1..-1].inject(conditions) do |conditions, table_name|
        conditions + " OR #{table_name}.user_id = #{user_id}"
      end
    with_role_stories.where(conditions)
    # once upgraded to Rails 5, do something like this:
    # with_role_stories.where(
    #   SetterStory.where(user: user).or(ManagerStory.where(user: user))
    # )
    # but with metaprogramming to handle all types of role stories
    #
    # once we have a RoleStory/RoleStories class/module, the inside of the where
    # clause above should be implemented in that class/module
  end

  def self.with_role_stories
    send_chain(*(
      role_story_tables.zip(role_story_types).map do |table_name, type|
        [:joins, <<-SQL]
          LEFT JOIN #{table_name}
          ON employments.role_story_id = #{table_name}.id
          AND employments.role_story_type = '#{type}'
        SQL
      end
    ))
  end
end
