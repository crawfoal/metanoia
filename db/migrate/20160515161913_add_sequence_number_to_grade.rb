class AddSequenceNumberToGrade < ActiveRecord::Migration
  def change
    add_column :grades, :sequence_number, :string, null: false
  end
end
