class AddAcumuladoToUser < ActiveRecord::Migration
  def change
    add_column :users, :pezzos_acumulados, :integer, default: 0
    add_column :users, :partidos_ganados, :integer, default: 0
    add_column :users, :partidos_perdidos, :integer, default: 0
  end
end
