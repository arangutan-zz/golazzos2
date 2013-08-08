class AddPezzosaapostarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pezzos_que_apuesta, :integer, default: 10000
  end
end
