class AddTorneoToPartidos < ActiveRecord::Migration
  def change
    add_column :partidos, :torneo, :integer
  end
end
