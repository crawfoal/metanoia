class CreateManagerStories < ActiveRecord::Migration
  def change
    create_table :manager_stories do |t|
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
