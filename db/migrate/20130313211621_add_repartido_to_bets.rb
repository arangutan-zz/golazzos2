class AddRepartidoToBets < ActiveRecord::Migration
  def change
    add_column :bets, :repartido, :boolean, default: false
    add_column :bets, :notificado, :boolean, default: false
  end
end
