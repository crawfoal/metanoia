class ChangeEmploymentGymToNullFalse < ActiveRecord::Migration
  def change
    change_column_null :employments, :gym_id, false
  end
end
