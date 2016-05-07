class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.string :name, null: false
      t.references :grade_system, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
