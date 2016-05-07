class ChangeSectionGymIdNullFalse < ActiveRecord::Migration
  def change
    change_column_null(:sections, :gym_id, false)
  end
end
