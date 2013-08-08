class AddReferidosToUser < ActiveRecord::Migration
  def change
    add_column :users, :referidos, :integer, default: 0
  end
end
