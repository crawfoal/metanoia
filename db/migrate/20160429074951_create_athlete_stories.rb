class CreateAthleteStories < ActiveRecord::Migration
  def change
    create_table :athlete_stories do |t|
      t.references :user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
