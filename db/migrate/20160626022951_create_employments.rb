class CreateEmployments < ActiveRecord::Migration
  def change
    create_table :employments do |t|
      t.references :gym, index: true, foreign_key: true
      t.references :role_story, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
