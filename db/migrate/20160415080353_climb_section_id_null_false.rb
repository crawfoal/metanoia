class ClimbSectionIdNullFalse < ActiveRecord::Migration
  def change
    change_column_null :climbs, :section_id, false
  end
end
