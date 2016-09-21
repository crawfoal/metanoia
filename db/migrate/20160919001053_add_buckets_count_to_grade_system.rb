class AddBucketsCountToGradeSystem < ActiveRecord::Migration
  def change
    add_column :grade_systems, :buckets_count, :integer, null: false, default: 0

    reversible do |dir|
      dir.up do
        execute <<-SQL.squish
          UPDATE grade_systems
          SET buckets_count = (
            SELECT count(*)
            FROM buckets
            WHERE buckets.grade_system_id = grade_systems.id
          )
        SQL
      end
    end
  end
end
