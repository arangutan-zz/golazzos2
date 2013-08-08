class AddRepartidoToPartidos < ActiveRecord::Migration
  def change
    add_column :partidos, :repartido, :boolean
  end
end
