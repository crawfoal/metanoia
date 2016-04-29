class CreateClimbLogs < ActiveRecord::Migration
  def change
    create_table :climb_logs do |t|
      t.references :athlete_story, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
