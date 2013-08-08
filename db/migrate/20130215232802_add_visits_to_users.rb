class AddVisitsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :visits_number, :integer, default: 0
  end
end
