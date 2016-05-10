class AddOrderToGrade < ActiveRecord::Migration
  def change
    add_column :grades, :order, :integer, null: false
  end
end
