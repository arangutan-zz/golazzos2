class AddEmailnotificationToPartidos < ActiveRecord::Migration
  def change
    add_column :partidos, :email_partido_cerrado, :boolean, default: false
    add_column :partidos, :email_partido_terminado, :boolean, default: false
  end
end
