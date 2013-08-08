class AddResultadosToUser < ActiveRecord::Migration
  def change
    add_column :users, :local_apostado, :integer, default: 0
    add_column :users, :visitante_apostado, :integer, default: 0
  end
end
