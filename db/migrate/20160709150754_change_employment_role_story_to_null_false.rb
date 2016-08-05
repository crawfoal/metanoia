class ChangeEmploymentRoleStoryToNullFalse < ActiveRecord::Migration
  def change
    change_column_null :employments, :role_story_id, false
    change_column_null :employments, :role_story_type, false
  end
end
