class AddSequenceNumberIntToGrade < ActiveRecord::Migration
  def change
    add_column :grades, :sequence_number, :integer, null: false
  end
end
