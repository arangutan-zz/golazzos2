class AddPezzosGanadosToBet < ActiveRecord::Migration
  def change
    add_column :bets, :pezzos_ganados, :integer
  end
end
