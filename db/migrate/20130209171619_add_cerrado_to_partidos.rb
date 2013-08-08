class AddCerradoToPartidos < ActiveRecord::Migration
  def change
    add_column :partidos, :cerrado, :boolean
  end
end
