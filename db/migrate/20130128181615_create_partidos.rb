class CreatePartidos < ActiveRecord::Migration
  def change
    create_table :partidos do |t|
      t.string :local
      t.string :visitante
      t.string :logolocal
      t.string :logovisitante
      t.datetime :diapartido

      t.timestamps
    end
  end
end
