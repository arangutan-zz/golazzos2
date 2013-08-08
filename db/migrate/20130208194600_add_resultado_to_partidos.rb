class AddResultadoToPartidos < ActiveRecord::Migration
  def change
    add_column :partidos, :resultadoLocal, :integer
    add_column :partidos, :resultadoVisitante, :integer
    add_column :partidos, :terminado, :boolean
  end
end
