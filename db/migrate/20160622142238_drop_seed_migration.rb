class DropSeedMigration < ActiveRecord::Migration
  def up
    drop_table :seed_migrations
  end

  def down
    raise ActiveRecord::IrreversableMigration
  end
end
