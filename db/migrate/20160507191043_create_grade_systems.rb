class CreateGradeSystems < ActiveRecord::Migration
  def change
    create_table :grade_systems do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
