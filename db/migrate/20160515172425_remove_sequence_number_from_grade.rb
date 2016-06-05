class RemoveSequenceNumberFromGrade < ActiveRecord::Migration
  def change
    remove_column :grades, :sequence_number, :string
  end
end
