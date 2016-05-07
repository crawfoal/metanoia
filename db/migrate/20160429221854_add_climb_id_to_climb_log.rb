class AddClimbIdToClimbLog < ActiveRecord::Migration
  def change
    add_reference :climb_logs, :climb, index: true, foreign_key: true, null: false
  end
end
