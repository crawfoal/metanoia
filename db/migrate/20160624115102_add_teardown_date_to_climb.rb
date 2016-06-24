class AddTeardownDateToClimb < ActiveRecord::Migration
  def change
    add_column :climbs, :teardown_date, :datetime
  end
end
