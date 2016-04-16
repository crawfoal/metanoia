class CreateClimbs < ActiveRecord::Migration
  def change
    create_table :climbs do |t|
      t.integer :color
      t.string :type, null: false
      t.integer :grade

      t.timestamps null: false
    end
  end
end
