class AddPezzosToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pezzos, :integer, default: 0
  end
end
