class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :athlete_story, index: true, foreign_key: true
      t.references :gym, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
