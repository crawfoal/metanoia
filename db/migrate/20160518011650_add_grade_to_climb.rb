class AddGradeToClimb < ActiveRecord::Migration
  def change
    add_reference :climbs, :grade, index: true, foreign_key: true
  end
end
