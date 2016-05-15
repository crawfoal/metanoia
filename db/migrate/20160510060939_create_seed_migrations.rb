class CreateSeedMigrations < ActiveRecord::Migration
  def change
    create_table :seed_migrations do |t|
      t.string :filename, null: false

      t.timestamps null: false
    end
  end
end
