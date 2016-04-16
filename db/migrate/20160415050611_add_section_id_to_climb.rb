class AddSectionIdToClimb < ActiveRecord::Migration
  def change
    add_reference :climbs, :section, index: true, foreign_key: true
  end
end
