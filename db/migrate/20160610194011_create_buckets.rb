class CreateBuckets < ActiveRecord::Migration
  def change
    create_table :buckets do |t|
      t.references :grade_system, index: true, foreign_key: true, null: false
      t.string :name, null: false
      t.references :lower_bound_grade, index: true
      t.references :upper_bound_grade, index: true

      t.timestamps null: false
    end
  end
end
